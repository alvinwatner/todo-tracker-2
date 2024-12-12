import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:todo_tracker/features/home/home_viewmodel.dart';
import 'package:todo_tracker/features/home/widgets/todo_item.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo Tracker'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: viewModel.showFilterOptions,
          ),
        ],
      ),
      body: viewModel.todos.isEmpty
          ? const Center(
              child: Text(
                'No todos yet!\nTap + to add a new todo',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              itemCount: viewModel.todos.length,
              itemBuilder: (context, index) {
                final todo = viewModel.todos[index];
                return TodoItem(
                  todo: todo,
                  onToggle: () => viewModel.toggleTodoCompletion(todo.id),
                  onDelete: () => viewModel.deleteTodo(todo.id),
                  onEdit: () => viewModel.editTodo(todo),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: viewModel.showAddTodoDialog,
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();
}
