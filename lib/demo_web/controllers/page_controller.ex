defmodule DemoWeb.PageController do
  use DemoWeb, :controller

  def index(conn, _params) do
    IO.inspect(conn.query_params)
    render conn, "index.html"
  end

  def count(conn, _) do
    Phoenix.LiveView.live_render(conn, DemoWeb.CounterView, session: %{params: conn.params})
  end
end
