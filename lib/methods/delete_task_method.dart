import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:script_05_task_tracker_app/widgets/widget_export.dart';

class DeleteTaskScreen extends StatelessWidget {
  const DeleteTaskScreen({
    super.key,
    required this.taskId,
  });

  final String taskId;

  Future deleteTask() async {
    await FirebaseFirestore.instance.collection('tasks').doc(taskId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      title: const Text(
        'Delete This Task',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      contentPadding: const EdgeInsets.all(38.0),
      content: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Are you sure you want to delete this task?'),
        ],
      ),
      actions: [
        ReusableButton(
          label: 'Cancel',
          textColor: Colors.blueAccent,
          navigatorFunction: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
        ),
        ReusableButton(
          label: 'Continue',
          textColor: Colors.redAccent,
          navigatorFunction: () {
            deleteTask();
            Navigator.of(context, rootNavigator: true).pop();
          },
        ),
      ],
    );
  }
}
