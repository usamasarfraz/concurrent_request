defmodule State do
  use GenServer
  def start_link(_args) do
    GenServer.start_link(__MODULE__,0, name: __MODULE__)
  end

  def insert(number) do
    GenServer.call(__MODULE__, {:insert_data, number})
  end

  def get() do
    GenServer.call(__MODULE__, {:get_data})
  end


  def init(state) do
    {:ok, state}
  end

  def handle_call({:insert_data, number}, _from, state) do
    {:reply, state + number, state + number}
  end

  def handle_call({:get_data}, _from, state) do
    {:reply, state, state}
  end
end
