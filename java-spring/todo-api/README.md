# Spring Boot TODO API

A simple RESTful TODO API built with Spring Boot.

## Features

- CRUD operations for todos
- In-memory storage using ConcurrentHashMap
- RESTful API endpoints
- JSON responses
- Input validation
- Error handling
- Thread-safe implementation

## Requirements

- Java 17 or higher
- Maven 3.6 or higher

## Setup

1. Build the project:
```bash
mvn clean install
```

2. Run the application:
```bash
mvn spring-boot:run
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
curl -X POST http://localhost:8080/api/todos \
  -H "Content-Type: application/json" \
  -d '{"title": "Learn Spring Boot", "completed": false}'
```

List all todos:
```bash
curl http://localhost:8080/api/todos
```

Update a todo:
```bash
curl -X PUT http://localhost:8080/api/todos/1 \
  -H "Content-Type: application/json" \
  -d '{"completed": true}'
```

Delete a todo:
```bash
curl -X DELETE http://localhost:8080/api/todos/1
```

## Response Format

All responses are in JSON format with snake_case property names:

```json
{
  "data": {
    "id": 1,
    "title": "Learn Spring Boot",
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
      "title": "Learn Spring Boot",
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
  "error": "Title is required"
}
```

When resource is not found:
```json
{
  "error": "Todo not found"
}
```

## Learn more

- [Spring Boot Documentation](https://docs.spring.io/spring-boot/docs/current/reference/html/)
- [Spring Web MVC](https://docs.spring.io/spring-framework/docs/current/reference/html/web.html)
- [Spring Boot API Guide](https://spring.io/guides/tutorials/rest/)
