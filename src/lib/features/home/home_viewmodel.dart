import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:todo_tracker/app/app.bottomsheets.dart';
import 'package:todo_tracker/app/app.dialogs.dart';
import 'package:todo_tracker/app/app.locator.dart';
import 'package:todo_tracker/features/home/todos_repository.dart';
import 'package:todo_tracker/models/todo.dart';

class HomeViewModel extends BaseViewModel {
  final _dialogService = locator<DialogService>();
  final _bottomSheetService = locator<BottomSheetService>();
  final _todosRepository = TodosRepository();

  List<Todo> _filteredTodos = [];
  bool _showCompleted = false;

  List<Todo> get todos => _filteredTodos;

  void initialize() {
    _updateTodosList();
  }

  void _updateTodosList() {
    _filteredTodos = _showCompleted
        ? _todosRepository.completedTodos
        : _todosRepository.pendingTodos;
    rebuildUi();
  }

  Future<void> showAddTodoDialog() async {
    final dialogResponse = await _dialogService.showCustomDialog(
      variant: DialogType.todoDialog,
      title: 'Add Todo',
    );

    if (dialogResponse?.confirmed == true && dialogResponse?.data != null) {
      final todo = dialogResponse!.data as Todo;
      _todosRepository.addTodo(todo);
      _updateTodosList();
    }
  }

  Future<void> editTodo(Todo todo) async {
    final dialogResponse = await _dialogService.showCustomDialog(
      variant: DialogType.todoDialog,
      title: 'Edit Todo',
      data: todo,
    );

    if (dialogResponse?.confirmed == true && dialogResponse?.data != null) {
      final updatedTodo = dialogResponse!.data as Todo;
      _todosRepository.updateTodo(updatedTodo);
      _updateTodosList();
    }
  }

  void deleteTodo(String id) {
    _todosRepository.deleteTodo(id);
    _updateTodosList();
  }

  void toggleTodoCompletion(String id) {
    _todosRepository.toggleTodoCompletion(id);
    _updateTodosList();
  }

  void showFilterOptions() async {
    final result = await _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.todoOptions,
      title: 'Filter Todos',
      data: _showCompleted,
    );

    if (result?.confirmed == true) {
      _showCompleted = result!.data as bool;
      _updateTodosList();
    }
  }
}
