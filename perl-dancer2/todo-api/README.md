# Dancer2 TODO API

A simple TODO API built with Perl's Dancer2 framework.

## Features

- RESTful API endpoints for CRUD operations
- JSON request/response format
- In-memory storage with thread-safe operations
- Input validation
- Proper error handling with HTTP status codes
- Clean and modular code structure

## Requirements

- Perl 5.16 or higher
- Dancer2
- JSON
- Time::HiRes

## Installation

1. Install the required Perl modules:

```bash
cpanm Dancer2 JSON
```

2. Clone the repository and navigate to the project directory:

```bash
cd perl-dancer2/todo-api
```

## Running the Application

Start the server:

```bash
./bin/app.pl
```

The API will be available at `http://localhost:8080`.

## API Endpoints

### List all todos
```bash
GET /api/todos
```

### Get a specific todo
```bash
GET /api/todos/:id
```

### Create a new todo
```bash
POST /api/todos
Content-Type: application/json

{
  "title": "Learn Dancer2",
  "completed": false
}
```

### Update a todo
```bash
PUT /api/todos/:id
Content-Type: application/json

{
  "title": "Learn Dancer2",
  "completed": true
}
```

### Delete a todo
```bash
DELETE /api/todos/:id
```

## Response Format

### Success Response
```json
{
  "data": {
    "id": 1,
    "title": "Learn Dancer2",
    "completed": false,
    "created_at": 1234567890.123
  }
}
```

### Error Response
```json
{
  "error": "Todo not found"
}
```

## HTTP Status Codes

- 200: Success
- 201: Created
- 204: No Content (successful deletion)
- 400: Bad Request
- 404: Not Found
- 500: Internal Server Error

## Development

The application uses an in-memory storage system for simplicity. In a production environment, you should replace this with a proper database backend.
