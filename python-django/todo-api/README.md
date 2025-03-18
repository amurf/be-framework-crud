# Django TODO API

A simple TODO API built with Python's Django framework and Django REST Framework.

## Features

- RESTful API endpoints for CRUD operations
- JSON request/response format
- SQLite database with Django ORM
- Input validation using Django REST Framework serializers
- CORS support
- Environment configuration
- Admin interface
- Proper error handling with HTTP status codes
- Clean and modular code structure

## Requirements

- Python 3.8 or higher
- Django and extensions (see requirements.txt)

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

3. Apply database migrations:

```bash
python manage.py migrate
```

## Running the Application

Start the development server:

```bash
python manage.py runserver
```

The API will be available at `http://localhost:8000`.

## API Endpoints

### List all todos
```bash
GET /api/todos/
```

### Get a specific todo
```bash
GET /api/todos/<id>/
```

### Create a new todo
```bash
POST /api/todos/
Content-Type: application/json

{
  "title": "Learn Django",
  "completed": false
}
```

### Update a todo
```bash
PUT /api/todos/<id>/
Content-Type: application/json

{
  "title": "Learn Django",
  "completed": true
}
```

### Delete a todo
```bash
DELETE /api/todos/<id>/
```

## Response Format

### Success Response
```json
{
  "data": {
    "id": 1,
    "title": "Learn Django",
    "completed": false,
    "created_at": "2024-03-14T12:00:00Z"
  }
}
```

### Error Response
```json
{
  "error": "Not found."
}
```

## HTTP Status Codes

- 200: Success
- 201: Created
- 204: No Content (successful deletion)
- 400: Bad Request (validation error)
- 404: Not Found
- 500: Internal Server Error

## Admin Interface

Django provides a built-in admin interface for managing todos:

1. Create a superuser:
```bash
python manage.py createsuperuser
```

2. Access the admin interface at `http://localhost:8000/admin/`

## Development

The application uses SQLite for simplicity. In a production environment, you should:

1. Use a production-grade database (e.g., PostgreSQL)
2. Set proper environment variables
3. Configure proper CORS settings
4. Add authentication and rate limiting
5. Use a production-grade WSGI server (e.g., Gunicorn)
6. Set DEBUG=False and configure proper security settings
7. Use proper static file serving
8. Implement proper logging
