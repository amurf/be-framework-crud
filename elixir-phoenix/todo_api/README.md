# Phoenix TODO API

A simple RESTful TODO API built with Elixir and Phoenix.

## Features

- CRUD operations for todos
- In-memory storage using ETS
- RESTful API endpoints
- JSON responses
- Error handling

## Setup

1. Install dependencies:
```bash
mix deps.get
```

2. Start the server:
```bash
mix phx.server
```

## API Endpoints

- `GET /api/todos` - List all todos
- `GET /api/todos/:id` - Get a specific todo
- `POST /api/todos` - Create a new todo
- `PUT /api/todos/:id` - Update a todo
- `DELETE /api/todos/:id` - Delete a todo

## Example Usage

Create a new todo:
```bash
curl -X POST http://localhost:4000/api/todos \
  -H "Content-Type: application/json" \
  -d '{"todo": {"title": "Learn Phoenix", "completed": false}}'
```

List all todos:
```bash
curl http://localhost:4000/api/todos
```

Update a todo:
```bash
curl -X PUT http://localhost:4000/api/todos/1 \
  -H "Content-Type: application/json" \
  -d '{"todo": {"completed": true}}'
```

Delete a todo:
```bash
curl -X DELETE http://localhost:4000/api/todos/1
```

## Response Format

All responses are in JSON format:

```json
{
  "data": {
    "id": 1,
    "title": "Learn Phoenix",
    "completed": false,
    "created_at": "2024-01-01T00:00:00Z"
  }
}
```

For list responses:
```json
{
  "data": [
    {
      "id": 1,
      "title": "Learn Phoenix",
      "completed": false,
      "created_at": "2024-01-01T00:00:00Z"
    }
  ]
}
```

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
