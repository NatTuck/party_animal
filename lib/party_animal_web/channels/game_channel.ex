defmodule PartyAnimalWeb.GameChannel do
  use PartyAnimalWeb, :channel

  alias PartyAnimal.Hangman.Game
  alias PartyAnimal.Hangman.Server


  @impl true
  def join("game:lobby", payload, socket) do
    if authorized?(payload) do
      {:ok, view} = Server.peek()
      {:ok, %{view: view}, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  @impl true
  def handle_in("get_view", payload, socket) do
    {:ok, view} = Server.peek()
    {:reply, {:ok, %{view: view}}, socket}
  end

  def handle_in("guess", %{"letter" => letter}, socket) do
    {:ok, view} = Server.guess(letter)
    broadcast(socket, "view", %{view: view})
    {:reply, {:ok, %{view: view}}, socket}
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
