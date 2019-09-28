defmodule DemoWeb.BarLive do
  use Phoenix.LiveView

  def render(assigns) do
    ~L"""
    <h2>Counter: <%= @counter %></h2>
    <button phx-click="inc">Inc</button>
    <%= for index <- @items do %>
      <h3>Item #<%= index %></h3>
      <div>
        Lorem ipsum dolor sit amet, consectetur adipiscing elit,
        sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
        Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris
        nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in
        reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.
        Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia
        deserunt mollit anim id est laborum.
      </div>
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
