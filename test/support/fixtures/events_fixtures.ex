defmodule PartyAnimal.EventsFixtures do

  alias PartyAnimal.UsersFixtures
  alias PartyAnimal.Events.Event

  @moduledoc """
  This module defines test helpers for creating
  entities via the `PartyAnimal.Events` context.
  """

  @doc """
  Generate a event.
  """
  def event_fixture(attrs \\ %{}) do
    user = UsersFixtures.user_fixture()

    {:ok, event} =
      attrs
      |> Enum.into(%{
        desc: "some desc",
        name: "some name",
        when: ~U[2024-09-08 14:58:00Z],
        user_id: user.id,
      })
      |> PartyAnimal.Events.create_event()

    %Event{ event | user: user }
  end
end
