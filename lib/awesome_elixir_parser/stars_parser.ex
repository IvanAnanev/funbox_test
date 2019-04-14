defmodule AwesomeElixirParser.StarsParser do
  use GenServer
  require Logger
  alias AwesomeElixirParser.Awesomes

  ## init

  def start_link(_), do: GenServer.start_link(__MODULE__, [], name: __MODULE__)

  def init(_), do: {:ok, []}

  ## API

  def parse(repository), do: GenServer.cast(__MODULE__, {:parse, repository})

  def handle_cast({:parse, %{link: link} = repository}, state) do
    if String.match?(link, ~r/github/) do
      link
      |> take_stars_and_last_commit()
      |> save_to_db(repository)
      |> log()
    end

    {:noreply, state}
  end

  @try_count 5
  @try_time 10_000
  defp take_stars_and_last_commit(url, count \\ 0)

  defp take_stars_and_last_commit(url, count) when count < @try_count do
    repo_info_url = url <> "/commits"

    repo_info_url |> Logger.debug()

    case HTTPoison.get(repo_info_url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        [el | _] = Floki.find(body, ".js-social-count")

        stars =
          el
          |> Floki.text()
          |> String.replace(",", "")
          |> String.trim()
          |> String.to_integer()

        [el | _] = Floki.find(body, "relative-time")
        [pushed_at | _] = Floki.attribute(el, "datetime")

        {:ok, stars, day_to_now(pushed_at)}

      # redirect to new path after moved repository
      {:ok, %HTTPoison.Response{status_code: 301, body: body}} ->
        [el | _] = Floki.find(body, "a")
        [new_url | _] = Floki.attribute(el, "href")

        new_link = String.replace(new_url, "/commits", "")
        Logger.debug("#{url} moved to #{new_link}")

        take_stars_and_last_commit(new_link)

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        {:error, "Not found #{url}"}

      {:ok, _} ->
        {:error, "Wrong link #{url}"}

      {:error, %HTTPoison.Error{reason: reason}} ->
        Logger.error("Parse error with reason: #{inspect(reason)}")
        :timer.sleep(@try_time)
        take_stars_and_last_commit(url, count + 1)
    end
  end

  defp take_stars_and_last_commit(url, @try_count),
    do: {:error, "After #{@try_count} try parse '#{url}' it stoped"}

  defp day_to_now(pushed_at) do
    {:ok, datetime, _} = DateTime.from_iso8601(pushed_at)
    Date.diff(Date.utc_today(), DateTime.to_date(datetime))
  end

  defp save_to_db({:error, _} = err, _), do: err

  defp save_to_db({:ok, stars, days}, repository) do
    Awesomes.update_repository(repository, %{stars: stars, days_from_last_commit: days})
  end

  defp log({:error, message}), do: Logger.error(message)
  defp log({:ok, repository}), do: Logger.info("Parsed stars for #{inspect(repository)}")
end
