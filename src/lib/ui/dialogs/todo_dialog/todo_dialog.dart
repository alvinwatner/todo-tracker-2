import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:todo_tracker/features/home/widgets/add_todo_form.dart';
import 'package:todo_tracker/models/todo.dart';

class TodoDialog extends StatelessWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const TodoDialog({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              request.title ?? 'Add Todo',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            AddTodoForm(
              initialTodo: request.data as Todo?,
              onSubmit: (todo) {
                completer(DialogResponse(confirmed: true, data: todo));
              },
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () => completer(DialogResponse(confirmed: false)),
              child: const Text('Cancel'),
            ),
          ],
        ),
      ),
    );
  }
}
