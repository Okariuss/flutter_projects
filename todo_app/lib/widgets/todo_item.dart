import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/constants/colors.dart';
import 'package:todo_app/models/toDoModel.dart';

import '../providers/todo_provider.dart';

class ToDoItem extends StatelessWidget {
  final ToDoModel todo;
  final onToDoChanged;
  final onDeleteItem;
  const ToDoItem(
      {super.key,
      required this.todo,
      required this.onToDoChanged,
      required this.onDeleteItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Consumer<ToDoProvider>(
        builder: (context, value, child) {
          return ListTile(
            onTap: () {
              onToDoChanged(todo, value);
            },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            tileColor: Colors.white,
            leading: Icon(
                todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
                color: tdBlue),
            title: Text(
              todo.toDoText ?? "",
              style: Theme.of(context).textTheme.subtitle1?.copyWith(
                  decoration: todo.isDone ? TextDecoration.lineThrough : null),
            ),
            trailing: Container(
              padding: const EdgeInsets.all(0),
              margin: const EdgeInsets.symmetric(vertical: 12),
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                color: tdRed,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Consumer<ToDoProvider>(
                builder: (context, value, child) {
                  return IconButton(
                    color: Colors.white,
                    icon: const Icon(Icons.delete),
                    iconSize: 18,
                    onPressed: () {
                      onDeleteItem(todo.id, value);
                    },
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
