defmodule AwesomeElixirParserWeb.PageControllerTest do
  use AwesomeElixirParserWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "AwesomeElixirParser"
  end
end
