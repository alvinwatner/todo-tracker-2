import 'package:todo_tracker/models/todo.dart';

class TodoService {
  final List<Todo> _todos = [];

  List<Todo> get todos => List.unmodifiable(_todos);

  void addTodo(Todo todo) {
    _todos.add(todo);
  }

  void updateTodo(Todo todo) {
    final index = _todos.indexWhere((t) => t.id == todo.id);
    if (index != -1) {
      _todos[index] = todo;
    }
  }

  void deleteTodo(String id) {
    _todos.removeWhere((todo) => todo.id == id);
  }

  void toggleTodoCompletion(String id) {
    final index = _todos.indexWhere((todo) => todo.id == id);
    if (index != -1) {
      final todo = _todos[index];
      _todos[index] = todo.copyWith(
        isCompleted: !todo.isCompleted,
        completedAt: !todo.isCompleted ? DateTime.now() : null,
      );
    }
  }

  List<Todo> getTodosByStatus(bool isCompleted) {
    return _todos.where((todo) => todo.isCompleted == isCompleted).toList();
  }
}
