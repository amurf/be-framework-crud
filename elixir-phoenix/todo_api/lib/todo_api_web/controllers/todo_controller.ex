defmodule TodoApiWeb.TodoController do
  use TodoApiWeb, :controller

  alias TodoApi.Todos
  alias TodoApi.Todos.Todo

  action_fallback TodoApiWeb.FallbackController

  def index(conn, _params) do
    todos = Todos.list_todos()
    render(conn, :index, todos: todos)
  end

  def show(conn, %{"id" => id}) do
    case Todos.get_todo!(id) do
      {:ok, todo} -> render(conn, :show, todo: todo)
      {:error, :not_found} -> conn |> put_status(:not_found) |> json(%{error: "Todo not found"})
    end
  end

  def create(conn, %{"todo" => todo_params}) do
    case Todos.create_todo(todo_params) do
      {:ok, todo} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", ~p"/api/todos/#{todo}")
        |> render(:show, todo: todo)
    end
  end

  def update(conn, %{"id" => id, "todo" => todo_params}) do
    case Todos.get_todo!(id) do
      {:ok, todo} ->
        case Todos.update_todo(todo, todo_params) do
          {:ok, todo} -> render(conn, :show, todo: todo)
          {:error, :not_found} -> conn |> put_status(:not_found) |> json(%{error: "Todo not found"})
        end
      {:error, :not_found} -> conn |> put_status(:not_found) |> json(%{error: "Todo not found"})
    end
  end

  def delete(conn, %{"id" => id}) do
    case Todos.get_todo!(id) do
      {:ok, todo} ->
        case Todos.delete_todo(todo) do
          {:ok, _todo} -> send_resp(conn, :no_content, "")
          {:error, :not_found} -> conn |> put_status(:not_found) |> json(%{error: "Todo not found"})
        end
      {:error, :not_found} -> conn |> put_status(:not_found) |> json(%{error: "Todo not found"})
    end
  end
end
