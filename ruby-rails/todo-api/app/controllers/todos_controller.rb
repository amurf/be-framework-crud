class TodosController < ApplicationController
  def index
    render json: { data: Todo.all }
  end

  def show
    todo = Todo.find(params[:id])
    if todo
      render json: { data: todo }
    else
      render json: { error: 'Todo not found' }, status: :not_found
    end
  end

  def create
    todo = Todo.new(todo_params)
    if todo.save
      render json: { data: todo }, status: :created
    else
      render json: { errors: todo.errors }, status: :unprocessable_entity
    end
  end

  def update
    todo = Todo.find(params[:id])
    if todo
      todo.attributes = todo_params
      if todo.save
        render json: { data: todo }
      else
        render json: { errors: todo.errors }, status: :unprocessable_entity
      end
    else
      render json: { error: 'Todo not found' }, status: :not_found
    end
  end

  def destroy
    todo = Todo.find(params[:id])
    if todo&.destroy
      head :no_content
    else
      render json: { error: 'Todo not found' }, status: :not_found
    end
  end

  private

  def todo_params
    params.require(:todo).permit(:title, :completed)
  end
end
