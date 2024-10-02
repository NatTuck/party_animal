defmodule PartyAnimalWeb.Ajax.InviteJSON do
  alias PartyAnimal.Invites.Invite

  alias PartyAnimalWeb.Ajax.UserJSON
  alias PartyAnimalWeb.Ajax.EventJSON
  
  @doc """
  Renders a list of invites.
  """
  def index(%{invites: invites}) do
    %{data: for(invite <- invites, do: data(invite))}
  end

  @doc """
  Renders a single invite.
  """
  def show(%{invite: invite}) do
    %{data: data(invite)}
  end

  defp data(%Invite{} = invite) do
    %{
      id: invite.id,
      response: invite.response,
      user: UserJSON.data(invite.user),
      event: EventJSON.data(invite.event),
    }
  end
end
