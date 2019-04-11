defmodule AwesomeElixirParserWeb.PageController do
  use AwesomeElixirParserWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
