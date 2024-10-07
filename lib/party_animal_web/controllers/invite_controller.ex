defmodule PartyAnimalWeb.InviteController do
  use PartyAnimalWeb, :controller

  alias PartyAnimal.Invites
  alias PartyAnimal.Invites.Invite

  def index(conn, _params) do
    invites = Invites.list_invites()
    render(conn, :index, invites: invites)
  end

  def new(conn, _params) do
    changeset = Invites.change_invite(%Invite{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"invite" => invite_params}) do

    invite_params = invite_params
    |> Map.put("event_id", 1)
    |> Map.put("user_id", 1)

    case Invites.create_invite(invite_params) do
      {:ok, invite} ->
        conn
        |> put_flash(:info, "Invite created successfully.")
        |> redirect(to: ~p"/invites/#{invite}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    invite = Invites.get_invite!(id)
    render(conn, :show, invite: invite)
  end

  def edit(conn, %{"id" => id}) do
    invite = Invites.get_invite!(id)
    changeset = Invites.change_invite(invite)
    render(conn, :edit, invite: invite, changeset: changeset)
  end

  def update(conn, %{"id" => id, "invite" => invite_params}) do
    invite = Invites.get_invite!(id)

    case Invites.update_invite(invite, invite_params) do
      {:ok, invite} ->
        conn
        |> put_flash(:info, "Invite updated successfully.")
        |> redirect(to: ~p"/invites/#{invite}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, invite: invite, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    invite = Invites.get_invite!(id)
    {:ok, _invite} = Invites.delete_invite(invite)

    conn
    |> put_flash(:info, "Invite deleted successfully.")
    |> redirect(to: ~p"/invites")
  end
end
