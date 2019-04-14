defmodule AwesomeElixirParserWeb.PageView do
  use AwesomeElixirParserWeb, :view

  @spec anchor(binary()) :: binary()
  def anchor(category_name) do
    category_name
    |> String.downcase()
    |> String.replace(~r/\/|\(|\)/, "")
    |> String.replace(" ", "-")
  end
end
