import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:script_05_task_tracker_app/widgets/widget_export.dart';

class ViewCompletedTask extends StatefulWidget {
  const ViewCompletedTask({super.key, required this.taskId});

  final String taskId;

  @override
  State<ViewCompletedTask> createState() => _ViewCompletedTaskState();
}

class _ViewCompletedTaskState extends State<ViewCompletedTask> {
  dynamic taskTitle;
  dynamic taskTag;
  dynamic taskDescription;
  dynamic initialDate;
  dynamic initialTime;
  dynamic finalDate;
  dynamic finalTime;

  @override
  void initState() {
    super.initState();
    fetchTaskData();
  }

  Future fetchTaskData() async {
    DocumentSnapshot taskSnapshot = await FirebaseFirestore.instance
        .collection('completed_tasks')
        .doc(widget.taskId)
        .get();
    if (taskSnapshot.exists) {
      Map<String, dynamic> data = taskSnapshot.data() as Map<String, dynamic>;
      setState(() {
        taskTitle = data['taskTitle'];
        taskDescription = data['taskDescription'];
        initialDate = data['initialDate'];
        initialTime = data['initialTime'];
        finalDate = data['finalDate'];
        finalTime = data['finalTime'];
        taskTag = data['taskTag'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          taskTitle ?? 'Loading...',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        children: [
          ViewCompletedTaskCard(
            taskDescription: 'Urgency',
            taskData: taskTag ?? 'Loading...',
            cardWidth: MediaQuery.sizeOf(context).width,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ViewCompletedTaskCard(
                taskDescription: 'Start Date',
                taskData: initialDate ?? 'Loading...',
                cardWidth: MediaQuery.sizeOf(context).width / 2.7,
              ),
              ViewCompletedTaskCard(
                taskDescription: 'Start Time',
                taskData: initialTime ?? 'Loading...',
                cardWidth: MediaQuery.sizeOf(context).width / 2.7,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ViewCompletedTaskCard(
                  taskDescription: 'End Date',
                  taskData: finalDate ?? 'Loading...',
                  cardWidth: MediaQuery.sizeOf(context).width / 2.7),
              ViewCompletedTaskCard(
                taskDescription: 'End Time',
                taskData: finalTime ?? 'Loading...',
                cardWidth: MediaQuery.sizeOf(context).width / 2.7,
              ),
            ],
          ),
          ViewCompletedTaskCard(
            taskDescription: 'Task Description',
            taskData: taskDescription ?? 'Loading...',
            cardWidth: MediaQuery.sizeOf(context).width,
          ),
        ],
      ),
    ));
  }
}
