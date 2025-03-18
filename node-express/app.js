const express = require('express');
const cors = require('cors');

const app = express();
const port = 3000;

// Middleware
app.use(cors());
app.use(express.json());

// In-memory storage
let todos = [];
let nextId = 1;

// GET /todos - List all todos
app.get('/todos', (req, res) => {
    res.json(todos);
});

// GET /todos/:id - Get a specific todo
app.get('/todos/:id', (req, res) => {
    const todo = todos.find(t => t.id === parseInt(req.params.id));
    if (!todo) {
        return res.status(404).json({ error: 'Todo not found' });
    }
    res.json(todo);
});

// POST /todos - Create a new todo
app.post('/todos', (req, res) => {
    const { title, completed = false } = req.body;
    if (!title) {
        return res.status(400).json({ error: 'Title is required' });
    }
    const todo = {
        id: nextId++,
        title,
        completed,
        createdAt: new Date().toISOString()
    };
    todos.push(todo);
    res.status(201).json(todo);
});

// PUT /todos/:id - Update a todo
app.put('/todos/:id', (req, res) => {
    const todo = todos.find(t => t.id === parseInt(req.params.id));
    if (!todo) {
        return res.status(404).json({ error: 'Todo not found' });
    }
    const { title, completed } = req.body;
    if (title !== undefined) todo.title = title;
    if (completed !== undefined) todo.completed = completed;
    res.json(todo);
});

// DELETE /todos/:id - Delete a todo
app.delete('/todos/:id', (req, res) => {
    const index = todos.findIndex(t => t.id === parseInt(req.params.id));
    if (index === -1) {
        return res.status(404).json({ error: 'Todo not found' });
    }
    todos.splice(index, 1);
    res.status(204).send();
});

app.listen(port, () => {
    console.log(`Express TODO API running at http://localhost:${port}`);
});
