defmodule PartyAnimalWeb.InviteHTML do
  use PartyAnimalWeb, :html

  embed_templates "invite_html/*"

  @doc """
  Renders a invite form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def invite_form(assigns)
end
