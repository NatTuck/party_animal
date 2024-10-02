defmodule PartyAnimal.InvitesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PartyAnimal.Invites` context.
  """

  @doc """
  Generate a invite.
  """
  def invite_fixture(attrs \\ %{}) do
    {:ok, invite} =
      attrs
      |> Enum.into(%{
        response: "some response"
      })
      |> PartyAnimal.Invites.create_invite()

    invite
  end
end
