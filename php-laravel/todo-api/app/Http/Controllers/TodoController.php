<?php

namespace App\Http\Controllers;

use App\Models\Todo;
use Illuminate\Http\Request;
use Illuminate\Http\Response;

class TodoController extends Controller
{
    public function index()
    {
        return response()->json([
            'data' => Todo::all()
        ]);
    }

    public function show(Todo $todo)
    {
        return response()->json([
            'data' => $todo
        ]);
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'title' => 'required|string|max:255',
            'completed' => 'boolean'
        ]);

        $todo = Todo::create($validated);

        return response()->json([
            'data' => $todo
        ], Response::HTTP_CREATED);
    }

    public function update(Request $request, Todo $todo)
    {
        $validated = $request->validate([
            'title' => 'string|max:255',
            'completed' => 'boolean'
        ]);

        $todo->update($validated);

        return response()->json([
            'data' => $todo
        ]);
    }

    public function destroy(Todo $todo)
    {
        $todo->delete();
        return response()->noContent();
    }
}
