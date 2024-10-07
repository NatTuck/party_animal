defmodule PartyAnimalWeb.Ajax.EventJSON do
  alias PartyAnimal.Events.Event

  @doc """
  Renders a list of events.
  """
  def index(%{events: events}) do
    %{data: for(event <- events, do: data(event))}
  end

  @doc """
  Renders a single event.
  """
  def show(%{event: event}) do
    %{data: data(event)}
  end

  def data(%Event{} = event) do
    %{
      id: event.id,
      name: event.name,
      when: event.when,
      desc: event.desc,
    }
  end
end
