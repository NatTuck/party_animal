defmodule PartyAnimal.Events.Event do
  use Ecto.Schema
  import Ecto.Changeset

  schema "events" do
    field :name, :string
    field :when, :utc_datetime
    field :desc, :string
    belongs_to :user, PartyAnimal.Users.User   # user_id, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(event, attrs) do
    event
    |> cast(attrs, [:name, :when, :desc, :user_id])
    |> validate_required([:name, :when, :desc, :user_id])
  end
end
