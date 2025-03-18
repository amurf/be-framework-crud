# Rails TODO API

A simple RESTful TODO API built with Ruby on Rails.

## Features

- CRUD operations for todos
- In-memory storage using Ruby class variables
- RESTful API endpoints
- JSON responses
- Input validation
- Error handling

## Setup

1. Install dependencies:
```bash
bundle install
```

2. Start the server:
```bash
rails server
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
curl -X POST http://localhost:3000/api/todos \
  -H "Content-Type: application/json" \
  -d '{"todo": {"title": "Learn Rails", "completed": false}}'
```

List all todos:
```bash
curl http://localhost:3000/api/todos
```

Update a todo:
```bash
curl -X PUT http://localhost:3000/api/todos/1 \
  -H "Content-Type: application/json" \
  -d '{"todo": {"completed": true}}'
```

Delete a todo:
```bash
curl -X DELETE http://localhost:3000/api/todos/1
```

## Response Format

All responses are in JSON format:

```json
{
  "data": {
    "id": 1,
    "title": "Learn Rails",
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
      "title": "Learn Rails",
      "completed": false,
      "created_at": "2024-01-01T00:00:00Z"
    }
  ]
}
```

## Error Responses

When validation fails:
```json
{
  "errors": {
    "title": ["can't be blank"]
  }
}
```

When resource is not found:
```json
{
  "error": "Todo not found"
}
```

## Learn more

- [Ruby on Rails Guides](https://guides.rubyonrails.org/)
- [Rails API Documentation](https://api.rubyonrails.org/)
- [Active Model Basics](https://guides.rubyonrails.org/active_model_basics.html)
