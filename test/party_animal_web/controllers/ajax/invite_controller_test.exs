defmodule PartyAnimalWeb.Ajax.InviteControllerTest do
  use PartyAnimalWeb.ConnCase

  import PartyAnimal.InvitesFixtures

  alias PartyAnimal.Invites.Invite

  @create_attrs %{
    response: "some response"
  }
  @update_attrs %{
    response: "some updated response"
  }
  @invalid_attrs %{response: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all invites", %{conn: conn} do
      conn = get(conn, ~p"/api/ajax/invites")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create invite" do
    test "renders invite when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/ajax/invites", invite: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/ajax/invites/#{id}")

      assert %{
               "id" => ^id,
               "response" => "some response"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/ajax/invites", invite: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update invite" do
    setup [:create_invite]

    test "renders invite when data is valid", %{conn: conn, invite: %Invite{id: id} = invite} do
      conn = put(conn, ~p"/api/ajax/invites/#{invite}", invite: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/ajax/invites/#{id}")

      assert %{
               "id" => ^id,
               "response" => "some updated response"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, invite: invite} do
      conn = put(conn, ~p"/api/ajax/invites/#{invite}", invite: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete invite" do
    setup [:create_invite]

    test "deletes chosen invite", %{conn: conn, invite: invite} do
      conn = delete(conn, ~p"/api/ajax/invites/#{invite}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/ajax/invites/#{invite}")
      end
    end
  end

  defp create_invite(_) do
    invite = invite_fixture()
    %{invite: invite}
  end
end
