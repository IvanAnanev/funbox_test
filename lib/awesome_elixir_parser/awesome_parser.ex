defmodule AwesomeElixirParser.AwesomeParser do
  use GenServer
  require Logger

  ## init

  def start_link(_), do: GenServer.start_link(__MODULE__, [], name: __MODULE__)

  def init(_), do: {:ok, [], {:continue, :init}}

  ## Callbacks

  def handle_continue(:init, state) do
    # schedule()
    parse()

    {:noreply, state}
  end

  def handle_info(:reparse, state) do
    schedule()
    parse()

    {:noreply, state}
  end

  # 24 * 60 * 60_000
  @once_daily 10_000
  defp schedule() do
    Process.send_after(self(), :reparse, @once_daily)
  end

  defp parse() do
    make_request()
    |> body_parse()
    |> save_to_db()

    # clear_noactual()
  end

  @awesome_elixir_url "https://github.com/h4cc/awesome-elixir"
  @try_count 5
  @try_time 10_000
  defp make_request(count \\ 0)

  defp make_request(count) when count < @try_count do
    case HTTPoison.get(@awesome_elixir_url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, body}

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        {:error, "Not found #{@awesome_elixir_url}"}

      {:error, %HTTPoison.Error{reason: reason}} ->
        Logger.error("Parse error with reason: #{inspect(reason)}")
        :timer.sleep(@try_time)
        make_request(count + 1)
    end
  end

  defp make_request(@try_count), do: {:error, "After #{@try_count} try it stoped"}

  defp body_parse({:error, _} = err), do: err

  defp body_parse({:ok, body}) do
    body
    |> take_article_children()
    |> parse_children()
  end

  defp save_to_db({:ok, parsed}) do
    Logger.info("Parsed: #{inspect(parsed)}")
  end

  defp take_article_children(body) do
    [{_, _, children} | _] = Floki.find(body, "article")
    children
  end

  # start parse from Actors category
  defp parse_children([{tag_name, _, _} = head | tail] = arr) do
    if tag_name == "h2" && Floki.text(head) == "Actors" do
      parse_children(arr, [%{}])
    else
      parse_children(tail)
    end
  end

  # category name
  defp parse_children([{"h2", _, _} = h_in | t_in], [_ | t_out]) do
    parse_children(t_in, [%{name: Floki.text(h_in)} | t_out])
  end

  # category description
  defp parse_children([{"p", _, _} = h_in | t_in], [h_out | t_out]) do
    description =
      h_in
      |> Floki.raw_html()
      |> String.replace("<p><em>", "")
      |> String.replace("</em></p>", "")

    parse_children(t_in, [Map.put(h_out, :description, description) | t_out])
  end

  # category repositories
  defp parse_children([{"ul", _, _} = h_in | t_in], [h_out | t_out]) do
    category_with_repositories = Map.put(h_out, :repositories, parse_repositories(h_in))

    if check_end_parse(t_in) do
      {:ok, [category_with_repositories | t_out]}
    else
      parse_children(t_in, [%{} | [category_with_repositories | t_out]])
    end
  end

  # end parse on Resources section
  defp check_end_parse([{tag, _, _} = el | _]) do
    tag == "h1" && Floki.text(el) == "Resources"
  end

  defp parse_repositories(ul) do
    Floki.find(ul, "li")
    |> Enum.map(&parse_repository(&1))
  end

  defp parse_repository(li) do
    # repository name
    [anchor | _] = Floki.find(li, "a")
    name = Floki.text(anchor)
    # repository description
    [_, description_html] =
      Floki.raw_html(li)
      |> String.split(" - ", parts: 2)

    description = String.replace(description_html, "</li>", "")
    # repository link
    [link | _] = Floki.attribute(anchor, "href")

    %{name: name, link: link, description: description}
  end
end
