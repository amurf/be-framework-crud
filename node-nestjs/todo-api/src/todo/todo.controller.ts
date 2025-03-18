import { Controller, Get, Post, Body, Put, Param, Delete, HttpCode, HttpStatus } from '@nestjs/common';
import { TodoService } from './todo.service';
import { Todo } from './interfaces/todo.interface';

@Controller('todos')
export class TodoController {
  constructor(private readonly todoService: TodoService) {}

  @Get()
  findAll(): { data: Todo[] } {
    return { data: this.todoService.findAll() };
  }

  @Get(':id')
  findOne(@Param('id') id: string): { data: Todo } {
    return { data: this.todoService.findOne(+id) };
  }

  @Post()
  @HttpCode(HttpStatus.CREATED)
  create(@Body() todo: Omit<Todo, 'id' | 'createdAt'>): { data: Todo } {
    return { data: this.todoService.create(todo) };
  }

  @Put(':id')
  update(@Param('id') id: string, @Body() todo: Partial<Todo>): { data: Todo } {
    return { data: this.todoService.update(+id, todo) };
  }

  @Delete(':id')
  @HttpCode(HttpStatus.NO_CONTENT)
  remove(@Param('id') id: string): void {
    this.todoService.remove(+id);
  }
}
