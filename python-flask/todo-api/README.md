# Flask TODO API

A simple TODO API built with Python's Flask framework.

## Features

- RESTful API endpoints for CRUD operations
- JSON request/response format
- In-memory storage with type hints
- Input validation using marshmallow
- CORS support
- Environment configuration
- Proper error handling with HTTP status codes
- Clean and modular code structure

## Requirements

- Python 3.8 or higher
- Flask and extensions (see requirements.txt)

## Installation

1. Create and activate a virtual environment:

```bash
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
```

2. Install dependencies:

```bash
pip install -r requirements.txt
```

## Running the Application

Start the development server:

```bash
python run.py
```

The API will be available at `http://localhost:8080`.

## API Endpoints

### List all todos
```bash
GET /api/todos
```

### Get a specific todo
```bash
GET /api/todos/<id>
```

### Create a new todo
```bash
POST /api/todos
Content-Type: application/json

{
  "title": "Learn Flask",
  "completed": false
}
```

### Update a todo
```bash
PUT /api/todos/<id>
Content-Type: application/json

{
  "title": "Learn Flask",
  "completed": true
}
```

### Delete a todo
```bash
DELETE /api/todos/<id>
```

## Response Format

### Success Response
```json
{
  "data": {
    "id": 1,
    "title": "Learn Flask",
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
- 400: Bad Request (validation error)
- 404: Not Found
- 500: Internal Server Error

## Development

The application uses an in-memory storage system for simplicity. In a production environment, you should:

1. Replace the in-memory storage with a proper database
2. Use a production-grade WSGI server (e.g., Gunicorn)
3. Set proper environment variables
4. Add authentication and rate limiting
5. Implement proper logging
