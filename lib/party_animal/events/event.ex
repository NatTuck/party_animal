defmodule PartyAnimal.Events.Event do
  use Ecto.Schema
  import Ecto.Changeset

  schema "events" do
    field :name, :string
    field :when, :utc_datetime
    field :desc, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(event, attrs) do
    event
    |> cast(attrs, [:name, :when, :desc])
    |> validate_required([:name, :when, :desc])
  end
end
