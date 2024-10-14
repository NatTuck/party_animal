defmodule PartyAnimalWeb.GameChannel do
  use PartyAnimalWeb, :channel

  alias PartyAnimal.Hangman.Game

  @impl true
  def join("game:lobby", payload, socket) do
    if authorized?(payload) do
      game = Game.new()

      socket = assign(socket, :game, game)
      {:ok, %{view: Game.view(game)}, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  @impl true
  def handle_in("get_view", payload, socket) do
    game = socket.assigns[:game]
    {:reply, {:ok, %{view: Game.view(game)}}, socket}
  end

  def handle_in("guess", %{"letter" => letter}, socket) do
    game = socket.assigns[:game]
    game = Game.guess(game, letter)
    socket = assign(socket, :game, game)
    {:reply, {:ok, %{view: Game.view(game)}}, socket}
  end


  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (game:lobby).
  @impl true
  def handle_in("shout", payload, socket) do
    broadcast(socket, "shout", payload)
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
