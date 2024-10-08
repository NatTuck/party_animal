defmodule PartyAnimalWeb.Ajax.UserControllerTest do
  use PartyAnimalWeb.ConnCase

  import PartyAnimal.UsersFixtures

  alias PartyAnimal.Users.User

  @create_attrs %{
    email: "some email",
    confirmed_at: ~U[2024-10-01 14:57:00Z]
  }
  @update_attrs %{
    email: "some updated email",
    confirmed_at: ~U[2024-10-02 14:57:00Z]
  }
  @invalid_attrs %{email: nil, confirmed_at: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all users", %{conn: conn} do
      conn = get(conn, ~p"/api/ajax/users")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create user" do
    test "renders user when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/ajax/users", user: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/ajax/users/#{id}")

      assert %{
               "id" => ^id,
               "confirmed_at" => "2024-10-01T14:57:00Z",
               "email" => "some email"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/ajax/users", user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update user" do
    setup [:create_user]

    test "renders user when data is valid", %{conn: conn, user: %User{id: id} = user} do
      conn = put(conn, ~p"/api/ajax/users/#{user}", user: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/ajax/users/#{id}")

      assert %{
               "id" => ^id,
               "confirmed_at" => "2024-10-02T14:57:00Z",
               "email" => "some updated email"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, user: user} do
      conn = put(conn, ~p"/api/ajax/users/#{user}", user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete user" do
    setup [:create_user]

    test "deletes chosen user", %{conn: conn, user: user} do
      conn = delete(conn, ~p"/api/ajax/users/#{user}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/ajax/users/#{user}")
      end
    end
  end

  defp create_user(_) do
    user = user_fixture()
    %{user: user}
  end
end
