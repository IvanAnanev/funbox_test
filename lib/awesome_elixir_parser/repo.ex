defmodule AwesomeElixirParser.Repo do
  use Ecto.Repo,
    otp_app: :awesome_elixir_parser,
    adapter: Ecto.Adapters.Postgres
end
