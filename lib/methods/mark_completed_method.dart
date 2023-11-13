import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:script_05_task_tracker_app/widgets/widget_export.dart';

class MarkTaskAsCompleted extends StatelessWidget {
  const MarkTaskAsCompleted({
    super.key,
    required this.taskId,
  });

  final String taskId;

  Future markTaskAsCompleted() async {
    DocumentSnapshot taskSnapshot =
        await FirebaseFirestore.instance.collection('tasks').doc(taskId).get();

    if (taskSnapshot.exists) {
      Map<String, dynamic> data = taskSnapshot.data() as Map<String, dynamic>;
      await FirebaseFirestore.instance
          .collection('completed_tasks')
          .doc()
          .set(data);
      await FirebaseFirestore.instance.collection('tasks').doc(taskId).delete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      title: const Text(
        'Task Completed',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      contentPadding: const EdgeInsets.all(38.0),
      content: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Congratulations on completing your task'),
        ],
      ),
      actions: [
        ReusableButton(
          label: 'Continue',
          textColor: Colors.blueAccent,
          navigatorFunction: () {
            markTaskAsCompleted();
            Navigator.of(context, rootNavigator: true).pop();
          },
        ),
      ],
    );
  }
}
