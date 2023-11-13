import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:script_05_task_tracker_app/widgets/widget_export.dart';

class EditTaskScreen extends StatefulWidget {
  const EditTaskScreen({
    super.key,
    required this.taskId,
  });

  final String taskId;

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  final titleEditingController = TextEditingController();
  final descriptionEditingController = TextEditingController();
  final initialDateEditingController = TextEditingController();
  final initialTimeEditingController = TextEditingController();
  final finalDateEditingController = TextEditingController();
  final finalTimeEditingController = TextEditingController();
  final taskTagEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchTaskData();
  }

  Future fetchTaskData() async {
    DocumentSnapshot taskSnapshot = await FirebaseFirestore.instance
        .collection('tasks')
        .doc(widget.taskId)
        .get();
    if (taskSnapshot.exists) {
      Map<String, dynamic> data = taskSnapshot.data() as Map<String, dynamic>;
      titleEditingController.text = data['taskTitle'];
      descriptionEditingController.text = data['taskDescription'];
      initialDateEditingController.text = data['initialDate'];
      initialTimeEditingController.text = data['initialTime'];
      finalDateEditingController.text = data['finalDate'];
      finalTimeEditingController.text = data['finalTime'];
      taskTagEditingController.text = data['taskTag'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Task',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(28.0),
        children: [
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
            listItems: const ['High', 'Moderate', 'Low'],
            listHint: 'Set Urgency',
            controller: taskTagEditingController,
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
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsets.zero,
        child: TextButton(
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),
              ),
            ),
            child: const Text('Update Task'),
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

                updateTask(
                  taskTitle,
                  taskTag,
                  initialDate,
                  initialTime,
                  finalDate,
                  finalTime,
                  taskDescription,
                );
                Navigator.of(context, rootNavigator: true).pop();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  behavior: SnackBarBehavior.floating,
                  elevation: 28.0,
                  content: Text('Fill all Fields'),
                ));
              }
            }),
      ),
    ));
  }

  Future updateTask(taskTitle, taskTag, initialDate, initialTime, finalDate,
      finalTime, taskDescription) async {
    CollectionReference taskCollection =
        FirebaseFirestore.instance.collection('tasks');
    await taskCollection.doc(widget.taskId).update({
      'taskTag': taskTag,
      'initialDate': initialDate,
      'initialTime': initialTime,
      'finalDate': finalDate,
      'finalTime': finalTime,
      'taskDescription': taskDescription,
    }).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          behavior: SnackBarBehavior.floating,
          elevation: 28.0,
          content: Text('The task has been successfully updated')));
    }).catchError((onError) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          behavior: SnackBarBehavior.floating,
          elevation: 28.0,
          content: Text('Something went wrong, please try again')));
    });
  }
}
