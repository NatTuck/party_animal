defmodule PartyAnimal.Invites.Invite do
  use Ecto.Schema
  import Ecto.Changeset

  schema "invites" do
    field :response, :string
    belongs_to :event, PartyAnimal.Events.Event
    belongs_to :user, PartyAnimal.Users.User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(invite, attrs) do
    invite
    |> cast(attrs, [:response, :event_id, :user_id])
    |> validate_required([:event_id, :user_id])
  end
end
