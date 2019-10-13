defmodule DemoWeb.ComponentEventsHeroLive do
  use Phoenix.LiveComponent

  def render(assigns) do
    # <h2><%= @title %></h2>
    ~L"""
    <section class="phx-hero">
      <h2><%= @title %></h2>
      <button phx-click="doit"><%= @button_text %></button>
      <%= @inner_content.([]) %>
    </section>
    """
  end

  def mount(socket) do
    {:ok, assign(socket, :button_text, "Hero Button")}
  end

  def handle_event("doit", _, socket) do
    {:noreply, assign(socket, :button_text, "Works!")}
  end

  # events triggered in @inner_content should not bet sent here
  def handle_event("inc", _, socket) do
    {:noreply, assign(socket, :button_text, "Wrong component!")}
  end
end

defmodule DemoWeb.ComponentEventsLive do
  use Phoenix.LiveView

  def render(assigns) do
    ~L"""
    <%= live_component @socket, DemoWeb.ComponentEventsHeroLive, id: 1, title: "Counter" do %>
      <div><%= @counter %></div>
      <button phx-click="inc">Inc</button>
    <% end %>
    """
  end

  def mount(_session, socket) do
    {:ok, socket |> assign(:counter, 0)}
  end

  def handle_event("inc", _, socket) do
    {:noreply, update(socket, :counter, &(&1 + 1))}
  end
end

