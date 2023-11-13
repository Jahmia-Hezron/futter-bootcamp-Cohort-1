import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:script_05_task_tracker_app/widgets/widget_export.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final titleEditingController = TextEditingController();
  final descriptionEditingController = TextEditingController();
  final initialDateEditingController = TextEditingController();
  final initialTimeEditingController = TextEditingController();
  final finalDateEditingController = TextEditingController();
  final finalTimeEditingController = TextEditingController();
  final taskTagEditingController = TextEditingController();

  Future addTask({
    required taskTitle,
    required taskTag,
    required initialDate,
    required initialTime,
    required finalDate,
    required finalTime,
    required taskDescription,
  }) async {
    CollectionReference taskCollection =
        FirebaseFirestore.instance.collection('tasks');

    String documentId = taskTitle;
    await taskCollection.doc(documentId).set({
      'taskTitle': taskTitle,
      'initialDate': initialDate,
      'initialTime': initialTime,
      'finalDate': finalDate,
      'finalTime': finalTime,
      'taskDescription': taskDescription,
      'taskTag': taskTag,
    });
    clearController();
  }

  clearController() {
    titleEditingController.clear();
    descriptionEditingController.clear();
    initialDateEditingController.clear();
    initialTimeEditingController.clear();
    finalDateEditingController.clear();
    finalTimeEditingController.clear();
    taskTagEditingController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).focusColor,
        centerTitle: true,
        title: const Text(
          'Create a Task',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(padding: const EdgeInsets.all(28.0), children: [
        ReusableFormField(
          controller: titleEditingController,
          hintText: 'Task Title',
          label: 'Task Title',
        ),
        Divider(
          thickness: 2.0,
          color: Theme.of(context).primaryColorLight,
        ),
        ReusableListField(
          controller: taskTagEditingController,
          listItems: const ['High', 'Moderate', 'Low'],
          listHint: 'Set Urgency',
          lable: 'Set Urgency',
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: MediaQuery.sizeOf(context).width / 2.5,
              child: ReusableDateField(
                controller: initialDateEditingController,
                hintText: 'Start Date',
                lable: 'Beginning Date',
              ),
            ),
            SizedBox(
              width: MediaQuery.sizeOf(context).width / 2.5,
              child: ReusableTimeField(
                controller: initialTimeEditingController,
                hintText: 'Start Time',
                lable: 'Beginning Time',
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: MediaQuery.sizeOf(context).width / 2.5,
              child: ReusableDateField(
                controller: finalDateEditingController,
                hintText: 'End Date',
                lable: 'Closing Date',
              ),
            ),
            SizedBox(
              width: MediaQuery.sizeOf(context).width / 2.5,
              child: ReusableTimeField(
                controller: finalTimeEditingController,
                hintText: 'End Time',
                lable: 'Closing Time',
              ),
            ),
          ],
        ),
        ReusableFormField(
          controller: descriptionEditingController,
          hintText: 'Description',
          textLines: 6,
          label: 'Task Description',
        ),
      ]),
      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsets.zero,
        child: TextButton(
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
            ),
          ),
          child: const Text('Save'),
          onPressed: () {
            if (titleEditingController.text.trim().isNotEmpty &&
                descriptionEditingController.text.trim().isNotEmpty &&
                initialTimeEditingController.text.trim().isNotEmpty &&
                initialDateEditingController.text.trim().isNotEmpty &&
                finalTimeEditingController.text.trim().isNotEmpty &&
                finalDateEditingController.text.trim().isNotEmpty &&
                taskTagEditingController.text.trim().isNotEmpty) {
              final taskTitle = titleEditingController.text;
              final initialDate = initialDateEditingController.text;
              final initialTime = initialTimeEditingController.text;
              final finalDate = finalDateEditingController.text;
              final finalTime = finalTimeEditingController.text;
              final taskDescription = descriptionEditingController.text;
              final taskTag = taskTagEditingController.text;

              addTask(
                taskTitle: taskTitle,
                taskTag: taskTag,
                initialDate: initialDate,
                initialTime: initialTime,
                finalDate: finalDate,
                finalTime: finalTime,
                taskDescription: taskDescription,
              );
              Navigator.of(context, rootNavigator: true).pop();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                behavior: SnackBarBehavior.floating,
                elevation: 28.0,
                content: Text('Fill all Fields'),
              ));
            }
          },
        ),
      ),
    ));
  }
}
