defmodule PartyAnimal.Hangman.Game do
  alias __MODULE__

  # Secret word is a string.
  # Guesses is a set of letters.
  defstruct [:secret, :guesses]



  def new() do
    %Game{secret: "walrus", guesses: MapSet.new()}
  end

  def view(%Game{secret: secret, guesses: guesses} = game) do
    skeleton = secret
    |> String.split("", trim: true)
    |> Enum.map(fn letter ->
      if MapSet.member?(guesses, letter) do
        letter
      else
        "_"
      end
    end)

    secret_letters = secret
    |> String.split("", trim: true)
    |> MapSet.new()

    bad_guesses = MapSet.difference(guesses, secret_letters)

    %{
      guesses: MapSet.to_list(guesses),
      skeleton: skeleton,
      lives: 5 - MapSet.size(bad_guesses),
    }
  end

  def guess(game, letter) do
    %Game{
      secret: game.secret,
      guesses: MapSet.put(game.guesses, letter),
    }
  end
end
