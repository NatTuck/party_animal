defmodule PartyAnimal.StateDemo do

  def listen(state) do
    receive do
      {:put, data} ->
        listen(data)
      {:get, pid} ->
        send(pid, state)
        listen(state)
    end
  end

end
