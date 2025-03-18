from time import time
from typing import Dict, List, Optional

class Todo:
    # In-memory storage
    _todos: Dict[int, 'Todo'] = {}
    _next_id: int = 1

    def __init__(self, title: str, completed: bool = False):
        self.id: Optional[int] = None
        self.title = title
        self.completed = completed
        self.created_at = time()

    @classmethod
    def get_all(cls) -> List['Todo']:
        """Return all todos."""
        return list(cls._todos.values())

    @classmethod
    def get_by_id(cls, todo_id: int) -> Optional['Todo']:
        """Get a todo by ID."""
        return cls._todos.get(todo_id)

    def save(self) -> 'Todo':
        """Save the todo to storage."""
        if self.id is None:
            self.id = self.__class__._next_id
            self.__class__._next_id += 1
        self.__class__._todos[self.id] = self
        return self

    def update(self, title: Optional[str] = None, completed: Optional[bool] = None) -> 'Todo':
        """Update the todo's attributes."""
        if title is not None:
            self.title = title
        if completed is not None:
            self.completed = completed
        return self.save()

    @classmethod
    def delete(cls, todo_id: int) -> bool:
        """Delete a todo by ID."""
        if todo_id in cls._todos:
            del cls._todos[todo_id]
            return True
        return False

    def to_dict(self) -> dict:
        """Convert the todo to a dictionary."""
        return {
            'id': self.id,
            'title': self.title,
            'completed': self.completed,
            'created_at': self.created_at
        }
