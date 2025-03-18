defmodule TodoApi.Todos do
  @moduledoc """
  The Todos context handles all todo-related operations.
  Uses in-memory storage with an ETS table.
  """

  use GenServer
  require Logger

  defmodule Todo do
    defstruct [:id, :title, :completed, :created_at]
  end

  # Client API

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def list_todos do
    GenServer.call(__MODULE__, :list_todos)
  end

  def get_todo!(id) do
    GenServer.call(__MODULE__, {:get_todo, id})
  end

  def create_todo(attrs \\ %{}) do
    GenServer.call(__MODULE__, {:create_todo, attrs})
  end

  def update_todo(%Todo{} = todo, attrs) do
    GenServer.call(__MODULE__, {:update_todo, todo, attrs})
  end

  def delete_todo(%Todo{} = todo) do
    GenServer.call(__MODULE__, {:delete_todo, todo})
  end

  # Server Callbacks

  @impl true
  def init(_state) do
    :ets.new(:todos_table, [:named_table, :public, :set])
    {:ok, %{next_id: 1}}
  end

  @impl true
  def handle_call(:list_todos, _from, state) do
    todos = :ets.tab2list(:todos_table)
      |> Enum.map(fn {_id, todo} -> todo end)
      |> Enum.sort_by(&(&1.id))
    {:reply, todos, state}
  end

  @impl true
  def handle_call({:get_todo, id}, _from, state) do
    case :ets.lookup(:todos_table, id) do
      [{^id, todo}] -> {:reply, {:ok, todo}, state}
      [] -> {:reply, {:error, :not_found}, state}
    end
  end

  @impl true
  def handle_call({:create_todo, attrs}, _from, state) do
    todo = %Todo{
      id: state.next_id,
      title: attrs["title"],
      completed: attrs["completed"] || false,
      created_at: DateTime.utc_now()
    }

    :ets.insert(:todos_table, {todo.id, todo})
    {:reply, {:ok, todo}, %{state | next_id: state.next_id + 1}}
  end

  @impl true
  def handle_call({:update_todo, todo, attrs}, _from, state) do
    updated_todo = %{todo |
      title: attrs["title"] || todo.title,
      completed: attrs["completed"] || todo.completed
    }

    :ets.insert(:todos_table, {updated_todo.id, updated_todo})
    {:reply, {:ok, updated_todo}, state}
  end

  @impl true
  def handle_call({:delete_todo, todo}, _from, state) do
    :ets.delete(:todos_table, todo.id)
    {:reply, {:ok, todo}, state}
  end
end
