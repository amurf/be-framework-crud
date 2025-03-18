from flask import jsonify, request, url_for
from marshmallow import ValidationError
from app.api import bp
from app.models import Todo
from app.schemas import todo_schema, todos_schema

@bp.route('/todos', methods=['GET'])
def get_todos():
    """Get all todos."""
    todos = Todo.get_all()
    return jsonify({'data': todos_schema.dump(todos)})

@bp.route('/todos/<int:id>', methods=['GET'])
def get_todo(id):
    """Get a specific todo."""
    todo = Todo.get_by_id(id)
    if todo is None:
        return jsonify({'error': 'Todo not found'}), 404
    return jsonify({'data': todo_schema.dump(todo)})

@bp.route('/todos', methods=['POST'])
def create_todo():
    """Create a new todo."""
    try:
        todo_data = todo_schema.load(request.get_json())
    except ValidationError as err:
        return jsonify({'error': err.messages}), 400

    todo = Todo(**todo_data)
    todo.save()

    response = jsonify({'data': todo_schema.dump(todo)})
    response.status_code = 201
    response.headers['Location'] = url_for('api.get_todo', id=todo.id)
    return response

@bp.route('/todos/<int:id>', methods=['PUT'])
def update_todo(id):
    """Update a todo."""
    todo = Todo.get_by_id(id)
    if todo is None:
        return jsonify({'error': 'Todo not found'}), 404

    try:
        todo_data = todo_schema.load(request.get_json(), partial=True)
    except ValidationError as err:
        return jsonify({'error': err.messages}), 400

    todo.update(**todo_data)
    return jsonify({'data': todo_schema.dump(todo)})

@bp.route('/todos/<int:id>', methods=['DELETE'])
def delete_todo(id):
    """Delete a todo."""
    if not Todo.delete(id):
        return jsonify({'error': 'Todo not found'}), 404
    return '', 204
