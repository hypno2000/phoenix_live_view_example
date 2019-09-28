defmodule DemoWeb.FooLive do
  use Phoenix.LiveView

  def render(assigns) do
    ~L"""
    <h2>Counter: <%= @counter %></h2>
    <button phx-click="inc">Inc</button>
    <%= for index <- @items do %>
      <h3>Item #<%= index %></h3>
      <%= DemoWeb.StaticView.render "index.html", assigns %>
    <% end %>
    """
  end

  def mount(_session, socket) do
    {:ok, socket |> assign(:counter, 0) |> assign(:items, 1..50)}
  end

  def handle_event("inc", _, socket) do
    {:noreply, update(socket, :counter, &(&1 + 1))}
  end
end
