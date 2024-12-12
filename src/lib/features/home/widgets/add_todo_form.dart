import 'package:flutter/material.dart';
import 'package:todo_tracker/models/todo.dart';

class AddTodoForm extends StatefulWidget {
  final Todo? initialTodo;
  final Function(Todo) onSubmit;

  const AddTodoForm({
    Key? key,
    this.initialTodo,
    required this.onSubmit,
  }) : super(key: key);

  @override
  AddTodoFormState createState() => AddTodoFormState();
}

class AddTodoFormState extends State<AddTodoForm> {
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.initialTodo?.title);
    _descriptionController = TextEditingController(
      text: widget.initialTodo?.description,
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final todo = Todo(
        id: widget.initialTodo?.id ?? DateTime.now().toString(),
        title: _titleController.text,
        description: _descriptionController.text,
        isCompleted: widget.initialTodo?.isCompleted ?? false,
        createdAt: widget.initialTodo?.createdAt ?? DateTime.now(),
        completedAt: widget.initialTodo?.completedAt,
      );
      widget.onSubmit(todo);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: _titleController,
            decoration: const InputDecoration(
              labelText: 'Title',
              hintText: 'Enter todo title',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a title';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _descriptionController,
            decoration: const InputDecoration(
              labelText: 'Description',
              hintText: 'Enter todo description',
            ),
            maxLines: 3,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _submitForm,
            child:
                Text(widget.initialTodo == null ? 'Add Todo' : 'Update Todo'),
          ),
        ],
      ),
    );
  }
}
