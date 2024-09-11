defmodule PartyAnimal.Repo.Migrations.CreateEvents do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :name, :string
      add :when, :utc_datetime
      add :desc, :text

      timestamps(type: :utc_datetime)
    end
  end
end
