import 'package:flutter/material.dart';

class TodoTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  Function(bool?)? onChanged;

  TodoTile(
      {super.key,
      required this.taskName,
      required this.taskCompleted,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: const Color.fromARGB(80, 190, 171, 227),
            borderRadius: BorderRadius.circular(12)
        ),
        child: Row(
          children: [
            //checkbox
            Checkbox(value: taskCompleted, onChanged: onChanged),

            //task name
            Text(taskName,
                style: TextStyle(
                    decoration: taskCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none)),
          ],
        ),
      ),
    );
  }
}
