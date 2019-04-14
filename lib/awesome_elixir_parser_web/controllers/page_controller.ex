defmodule AwesomeElixirParserWeb.PageController do
  use AwesomeElixirParserWeb, :controller
  alias AwesomeElixirParser.Awesomes
  require Logger

  def index(conn, %{"min_stars" => min_stars}) do
    categories = Awesomes.filtered_list_categories_with_repositories(String.to_integer(min_stars))
    render(conn, "index.html", categories: categories)
  end

  def index(conn, _params) do
    categories = Awesomes.list_categories_with_repositories()
    render(conn, "index.html", categories: categories)
  end
end
