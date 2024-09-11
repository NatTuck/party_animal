defmodule PartyAnimal.EventsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PartyAnimal.Events` context.
  """

  @doc """
  Generate a event.
  """
  def event_fixture(attrs \\ %{}) do
    {:ok, event} =
      attrs
      |> Enum.into(%{
        desc: "some desc",
        name: "some name",
        when: ~U[2024-09-08 14:58:00Z]
      })
      |> PartyAnimal.Events.create_event()

    event
  end
end
