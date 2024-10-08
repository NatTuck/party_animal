defmodule PartyAnimalWeb.Ajax.InviteController do
  use PartyAnimalWeb, :controller

  alias PartyAnimal.Invites
  alias PartyAnimal.Invites.Invite

  action_fallback PartyAnimalWeb.FallbackController

  def index(conn, _params) do
    invites = Invites.list_invites()
    render(conn, :index, invites: invites)
  end

  def create(conn, %{"invite" => invite_params}) do
    with {:ok, %Invite{} = invite} <- Invites.create_invite(invite_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/ajax/invites/#{invite}")
      |> render(:show, invite: invite)
    end
  end

  def show(conn, %{"id" => id}) do
    invite = Invites.get_invite!(id)
    render(conn, :show, invite: invite)
  end

  def update(conn, %{"id" => id, "invite" => invite_params}) do
    invite = Invites.get_invite!(id)

    with {:ok, %Invite{} = invite} <- Invites.update_invite(invite, invite_params) do
      render(conn, :show, invite: invite)
    end
  end

  def delete(conn, %{"id" => id}) do
    invite = Invites.get_invite!(id)

    with {:ok, %Invite{}} <- Invites.delete_invite(invite) do
      send_resp(conn, :no_content, "")
    end
  end
end
