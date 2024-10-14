defmodule PartyAnimalWeb.PageController do
  use PartyAnimalWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    users = PartyAnimal.Users.list_users()
    |> PartyAnimalWeb.Ajax.UserJSON.user_list()

    events = PartyAnimal.Events.list_events()
    |> PartyAnimalWeb.Ajax.EventJSON.event_list()

    render(conn, :home, users: users, events: events)
  end

  def hangman(conn, _params) do
    render(conn, :hangman)
  end
end
