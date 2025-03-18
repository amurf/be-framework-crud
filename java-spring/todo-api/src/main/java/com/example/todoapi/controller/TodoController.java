package com.example.todoapi.controller;

import com.example.todoapi.model.Todo;
import com.example.todoapi.service.TodoService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Collections;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/todos")
public class TodoController {
    private final TodoService todoService;

    public TodoController(TodoService todoService) {
        this.todoService = todoService;
    }

    @GetMapping
    public ResponseEntity<Map<String, List<Todo>>> findAll() {
        return ResponseEntity.ok(Collections.singletonMap("data", todoService.findAll()));
    }

    @GetMapping("/{id}")
    public ResponseEntity<Map<String, Object>> findById(@PathVariable Long id) {
        Todo todo = todoService.findById(id);
        if (todo == null) {
            return ResponseEntity
                .status(HttpStatus.NOT_FOUND)
                .body(Collections.singletonMap("error", "Todo not found"));
        }
        return ResponseEntity.ok(Collections.singletonMap("data", todo));
    }

    @PostMapping
    public ResponseEntity<Map<String, Object>> create(@RequestBody Todo todo) {
        if (todo.getTitle() == null || todo.getTitle().trim().isEmpty()) {
            return ResponseEntity
                .status(HttpStatus.BAD_REQUEST)
                .body(Collections.singletonMap("error", "Title is required"));
        }
        Todo created = todoService.create(todo);
        return ResponseEntity
            .status(HttpStatus.CREATED)
            .body(Collections.singletonMap("data", created));
    }

    @PutMapping("/{id}")
    public ResponseEntity<Map<String, Object>> update(@PathVariable Long id, @RequestBody Todo todo) {
        Todo updated = todoService.update(id, todo);
        if (updated == null) {
            return ResponseEntity
                .status(HttpStatus.NOT_FOUND)
                .body(Collections.singletonMap("error", "Todo not found"));
        }
        return ResponseEntity.ok(Collections.singletonMap("data", updated));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        if (todoService.delete(id)) {
            return ResponseEntity.noContent().build();
        }
        return ResponseEntity.notFound().build();
    }
}
