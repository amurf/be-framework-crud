package com.example.todoapi.service;

import com.example.todoapi.model.Todo;
import org.springframework.stereotype.Service;

import java.time.Instant;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.atomic.AtomicLong;

@Service
public class TodoService {
    private final Map<Long, Todo> todos = new ConcurrentHashMap<>();
    private final AtomicLong nextId = new AtomicLong(1);

    public List<Todo> findAll() {
        return new ArrayList<>(todos.values());
    }

    public Todo findById(Long id) {
        return todos.get(id);
    }

    public Todo create(Todo todo) {
        todo.setId(nextId.getAndIncrement());
        todo.setCreatedAt(Instant.now());
        todos.put(todo.getId(), todo);
        return todo;
    }

    public Todo update(Long id, Todo todo) {
        if (!todos.containsKey(id)) {
            return null;
        }
        todo.setId(id);
        todo.setCreatedAt(todos.get(id).getCreatedAt());
        todos.put(id, todo);
        return todo;
    }

    public boolean delete(Long id) {
        return todos.remove(id) != null;
    }
}
