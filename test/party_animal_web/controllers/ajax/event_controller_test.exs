defmodule PartyAnimalWeb.Ajax.EventControllerTest do
  use PartyAnimalWeb.ConnCase

  import PartyAnimal.EventsFixtures

  alias PartyAnimal.Events.Event

  @create_attrs %{
    name: "some name",
    desc: "some desc",
    when: ~U[2024-10-01 14:56:00Z],
    image: "some image"
  }
  @update_attrs %{
    name: "some updated name",
    desc: "some updated desc",
    when: ~U[2024-10-02 14:56:00Z],
    image: "some updated image"
  }
  @invalid_attrs %{name: nil, desc: nil, when: nil, image: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all events", %{conn: conn} do
      conn = get(conn, ~p"/api/ajax/events")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create event" do
    test "renders event when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/ajax/events", event: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/ajax/events/#{id}")

      assert %{
               "id" => ^id,
               "desc" => "some desc",
               "image" => "some image",
               "name" => "some name",
               "when" => "2024-10-01T14:56:00Z"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/ajax/events", event: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update event" do
    setup [:create_event]

    test "renders event when data is valid", %{conn: conn, event: %Event{id: id} = event} do
      conn = put(conn, ~p"/api/ajax/events/#{event}", event: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/ajax/events/#{id}")

      assert %{
               "id" => ^id,
               "desc" => "some updated desc",
               "image" => "some updated image",
               "name" => "some updated name",
               "when" => "2024-10-02T14:56:00Z"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, event: event} do
      conn = put(conn, ~p"/api/ajax/events/#{event}", event: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete event" do
    setup [:create_event]

    test "deletes chosen event", %{conn: conn, event: event} do
      conn = delete(conn, ~p"/api/ajax/events/#{event}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/ajax/events/#{event}")
      end
    end
  end

  defp create_event(_) do
    event = event_fixture()
    %{event: event}
  end
end
