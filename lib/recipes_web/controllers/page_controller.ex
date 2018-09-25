defmodule RecipesWeb.PageController do
  use RecipesWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
