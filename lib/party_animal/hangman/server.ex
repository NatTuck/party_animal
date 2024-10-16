defmodule PartyAnimal.Hangman.Server do
  use GenServer

  alias PartyAnimal.Hangman.Game

  # Server Interface

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def guess(letter) do
    GenServer.call(__MODULE__, {:guess, letter})
  end

  def peek() do
    GenServer.call(__MODULE__, :peek)
  end
  

  # Server Implementation:

  @impl true
  def init(_junk) do
    game0 = Game.new()
    {:ok, game0}
  end

  @impl true
  def handle_call({:guess, letter}, _from, game0) do
    game1 = Game.guess(game0, letter)
    {:reply, {:ok, Game.view(game1)}, game1}
  end

  def handle_call(:peek, _from, game) do
    {:reply, {:ok, Game.view(game)}, game}
  end
end
