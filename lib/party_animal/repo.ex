defmodule PartyAnimal.Repo do
  use Ecto.Repo,
    otp_app: :party_animal,
    adapter: Ecto.Adapters.SQLite3
end
