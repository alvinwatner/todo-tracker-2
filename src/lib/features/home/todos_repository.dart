import 'package:todo_tracker/app/app.locator.dart';
import 'package:todo_tracker/models/todo.dart';
import 'package:todo_tracker/services/todo_service.dart';

class TodosRepository {
  final _todoService = locator<TodoService>();

  List<Todo> get allTodos => _todoService.todos;

  List<Todo> get completedTodos => _todoService.getTodosByStatus(true);

  List<Todo> get pendingTodos => _todoService.getTodosByStatus(false);

  void addTodo(Todo todo) {
    _todoService.addTodo(todo);
  }

  void updateTodo(Todo todo) {
    _todoService.updateTodo(todo);
  }

  void deleteTodo(String id) {
    _todoService.deleteTodo(id);
  }

  void toggleTodoCompletion(String id) {
    _todoService.toggleTodoCompletion(id);
  }
}
