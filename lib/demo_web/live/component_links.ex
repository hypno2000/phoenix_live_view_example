defmodule DemoWeb.ComponentLinksHeroLive do
  use Phoenix.LiveComponent
  alias DemoWeb.Router.Helpers, as: Routes

  def render(assigns) do
    # <h2><%= @title %></h2>
    ~L"""
    <section class="phx-hero">
      <h2><%= @title %></h2>
      <button phx-click="doit"><%= @button_text %></button>
      <%= @inner_content.([]) %>
      <%= live_link to: Routes.live_path(@socket, DemoWeb.ComponentLinksLive, ["hello" , "from", "component"]) do %>
        Link in Hero #1 (in component)
      <% end %>
      <br/>
      <%= live_link to: Routes.live_path(@socket, DemoWeb.ComponentLinks2Live, ["hello" , "from", "component2"]) do %>
        Link in Hero #2 (in component)
      <% end %>
      <br/>
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

defmodule DemoWeb.ComponentLinksLive do
  use Phoenix.LiveView
  alias DemoWeb.Router.Helpers, as: Routes

  def render(assigns) do
    ~L"""
    <h1>LiveView #1</h1>
    <%= live_link to: Routes.live_path(@socket, DemoWeb.ComponentLinksLive, ["hello", "from", "live-view"]) do %>
      Link in live view #1
    <% end %>
    <br/>
    <%= live_link to: Routes.live_path(@socket, DemoWeb.ComponentLinks2Live, ["hello", "from", "live-view2"]) do %>
      Link in live view #2
    <% end %>
    <br/>
    <%= live_component @socket, DemoWeb.ComponentLinksHeroLive, id: 1, title: "Counter" do %>
      <div><%= @counter %></div>
      <button phx-click="inc">Inc</button>
      <br/>
      <%= live_link to: Routes.live_path(@socket, DemoWeb.ComponentLinksLive, ["hello", "from", "inner-content"]) do %>
        Link in inner content #1 (in live view)
      <% end %>
      <br/>
      <%= live_link to: Routes.live_path(@socket, DemoWeb.ComponentLinks2Live, ["hello", "from", "inner-content2"]) do %>
        Link in inner content #2 (in live view)
      <% end %>
      <br/>
    <% end %>
    <pre>
      <%= inspect @path, pretty: true %>
    </pre>
    """
  end

  def mount(_session, socket) do
    {:ok, socket |> assign(:counter, 0)}
  end

  def handle_event("inc", _, socket) do
    {:noreply, update(socket, :counter, &(&1 + 1))}
  end

  def handle_params(%{"path" => path}, _, socket) do
    {:noreply, socket |> assign(:path, path)}
  end
end


defmodule DemoWeb.ComponentLinks2Live do
  use Phoenix.LiveView
  alias DemoWeb.Router.Helpers, as: Routes

  def render(assigns) do
    ~L"""
    <h1>LiveView #2</h1>
    <%= live_link to: Routes.live_path(@socket, DemoWeb.ComponentLinksLive, ["hello", "from", "live-view"]) do %>
      Link in live view #1
    <% end %>
    <br/>
    <%= live_link to: Routes.live_path(@socket, DemoWeb.ComponentLinks2Live, ["hello", "from", "live-view2"]) do %>
      Link in live view #2
    <% end %>
    <br/>
    <%= live_component @socket, DemoWeb.ComponentLinksHeroLive, id: 1, title: "Counter" do %>
      <div><%= @counter %></div>
      <button phx-click="inc">Inc</button>
      <br/>
      <%= live_link to: Routes.live_path(@socket, DemoWeb.ComponentLinksLive, ["hello", "from", "inner-content"]) do %>
        Link in inner content #1 (in live view)
      <% end %>
      <br/>
      <%= live_link to: Routes.live_path(@socket, DemoWeb.ComponentLinks2Live, ["hello", "from", "inner-content2"]) do %>
        Link in inner content #2 (in live view)
      <% end %>
      <br/>
    <% end %>
    <pre>
      <%= inspect @path, pretty: true %>
    </pre>
    """
  end

  def mount(_session, socket) do
    {:ok, socket |> assign(:counter, 0)}
  end

  def handle_event("inc", _, socket) do
    {:noreply, update(socket, :counter, &(&1 + 1))}
  end

  def handle_params(%{"path" => path}, _, socket) do
    {:noreply, socket |> assign(:path, path)}
  end
end
