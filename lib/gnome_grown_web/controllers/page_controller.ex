defmodule GnomeGrownWeb.PageController do
  use GnomeGrownWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
