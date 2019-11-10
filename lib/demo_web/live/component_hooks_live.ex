defmodule DemoWeb.ComponentHooksLive do
  use Phoenix.LiveView

  def render(assigns) do
    ~L"""
    <div>
      <button phx-click="inc">+</button>
      <button phx-click="dec">-</button>
      <div><%= @counter %></div>
      <%= if @counter == 2 do %>
        <input value="with hook" phx-hook="PhoneNumber" />
      <% else %>
        <input value="without hook" />
      <% end %>
    </div>
    """
  end

  def mount(_session, socket) do
    {:ok, socket |> assign(:counter, 0)}
  end

  def handle_event("inc", _, socket) do
    {:noreply, update(socket, :counter, &(&1 + 1))}
  end

  def handle_event("dec", _, socket) do
    {:noreply, update(socket, :counter, &(&1 - 1))}
  end
end

