defmodule YoyakuWeb.PageController do
  use YoyakuWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
