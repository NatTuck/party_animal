defmodule PartyAnimal.Events.Event do
  alias __MODULE__

  use Ecto.Schema
  import Ecto.Changeset

  schema "events" do
    field :name, :string
    field :when, :utc_datetime
    field :desc, :string
    field :image, :binary
    belongs_to :user, PartyAnimal.Users.User   # user_id, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(event, attrs) do
    event
    |> cast(attrs, [:name, :when, :desc, :user_id])
    |> validate_required([:name, :when, :desc, :user_id])
    |> update_image(attrs)
  end

  def update_image(cset, %{"image" => image}) do
    data = File.read!(image.path)
    put_change(cset, :image, data) 
  end
  def update_image(cset, _no_image) do
    cset
  end
end
