defmodule PartyAnimal.Repo.Migrations.AddImageToEvent do
  use Ecto.Migration

  def change do
    alter table("events") do
      add :image, :binary
    end
  end
end
