import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

class TodoOptionsSheet extends StatelessWidget {
  final Function(SheetResponse)? completer;
  final SheetRequest request;

  const TodoOptionsSheet({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            request.title ?? 'Filter Todos',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          ListTile(
            title: const Text('Show Pending'),
            leading: Radio<bool>(
              value: false,
              groupValue: request.data as bool,
              onChanged: (value) => completer?.call(
                SheetResponse(confirmed: true, data: false),
              ),
            ),
            onTap: () => completer?.call(
              SheetResponse(confirmed: true, data: false),
            ),
          ),
          ListTile(
            title: const Text('Show Completed'),
            leading: Radio<bool>(
              value: true,
              groupValue: request.data as bool,
              onChanged: (value) => completer?.call(
                SheetResponse(confirmed: true, data: true),
              ),
            ),
            onTap: () => completer?.call(
              SheetResponse(confirmed: true, data: true),
            ),
          ),
        ],
      ),
    );
  }
}
