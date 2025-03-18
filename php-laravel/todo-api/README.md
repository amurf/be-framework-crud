# Laravel TODO API

A simple RESTful TODO API built with Laravel.

## Features

- CRUD operations for todos
- SQLite database storage
- RESTful API endpoints
- JSON responses
- Input validation
- Error handling

## Setup

1. Install dependencies:
```bash
composer install
```

2. Configure environment:
```bash
cp .env.example .env
php artisan key:generate
```

3. Run migrations:
```bash
php artisan migrate
```

4. Start the server:
```bash
php artisan serve
```

## API Endpoints

- `GET /api/todos` - List all todos
- `GET /api/todos/{id}` - Get a specific todo
- `POST /api/todos` - Create a new todo
- `PUT /api/todos/{id}` - Update a todo
- `DELETE /api/todos/{id}` - Delete a todo

## Example Usage

Create a new todo:
```bash
curl -X POST http://localhost:8000/api/todos \
  -H "Content-Type: application/json" \
  -d '{"title": "Learn Laravel", "completed": false}'
```

List all todos:
```bash
curl http://localhost:8000/api/todos
```

Update a todo:
```bash
curl -X PUT http://localhost:8000/api/todos/1 \
  -H "Content-Type: application/json" \
  -d '{"completed": true}'
```

Delete a todo:
```bash
curl -X DELETE http://localhost:8000/api/todos/1
```

## Response Format

All responses are in JSON format:

```json
{
  "data": {
    "id": 1,
    "title": "Learn Laravel",
    "completed": false,
    "created_at": "2024-01-01T00:00:00.000000Z",
    "updated_at": "2024-01-01T00:00:00.000000Z"
  }
}
```

For list responses:
```json
{
  "data": [
    {
      "id": 1,
      "title": "Learn Laravel",
      "completed": false,
      "created_at": "2024-01-01T00:00:00.000000Z",
      "updated_at": "2024-01-01T00:00:00.000000Z"
    }
  ]
}
```

## Learn more

- [Laravel Documentation](https://laravel.com/docs)
- [Laravel API Resources](https://laravel.com/docs/eloquent-resources)
- [Laravel Validation](https://laravel.com/docs/validation)
