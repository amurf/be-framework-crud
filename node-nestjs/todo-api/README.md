# NestJS TODO API

A simple RESTful TODO API built with NestJS.

## Features

- CRUD operations for todos
- In-memory storage
- RESTful API endpoints
- JSON responses
- Input validation
- Error handling
- TypeScript support

## Setup

1. Install dependencies:
```bash
npm install
```

2. Start the server:
```bash
npm run start:dev
```

## API Endpoints

- `GET /todos` - List all todos
- `GET /todos/:id` - Get a specific todo
- `POST /todos` - Create a new todo
- `PUT /todos/:id` - Update a todo
- `DELETE /todos/:id` - Delete a todo

## Example Usage

Create a new todo:
```bash
curl -X POST http://localhost:3000/todos \
  -H "Content-Type: application/json" \
  -d '{"title": "Learn NestJS", "completed": false}'
```

List all todos:
```bash
curl http://localhost:3000/todos
```

Update a todo:
```bash
curl -X PUT http://localhost:3000/todos/1 \
  -H "Content-Type: application/json" \
  -d '{"completed": true}'
```

Delete a todo:
```bash
curl -X DELETE http://localhost:3000/todos/1
```

## Response Format

All responses are in JSON format:

```json
{
  "data": {
    "id": 1,
    "title": "Learn NestJS",
    "completed": false,
    "createdAt": "2024-01-01T00:00:00.000Z"
  }
}
```

For list responses:
```json
{
  "data": [
    {
      "id": 1,
      "title": "Learn NestJS",
      "completed": false,
      "createdAt": "2024-01-01T00:00:00.000Z"
    }
  ]
}
```

## Learn more

- [NestJS Documentation](https://docs.nestjs.com/)
- [NestJS Controllers](https://docs.nestjs.com/controllers)
- [NestJS Providers](https://docs.nestjs.com/providers)
