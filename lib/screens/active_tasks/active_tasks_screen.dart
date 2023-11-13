import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:script_05_task_tracker_app/methods/method_export.dart';
import 'package:script_05_task_tracker_app/screens/screens_export.dart';
import 'package:script_05_task_tracker_app/widgets/widget_export.dart';

class ActiveTasks extends StatelessWidget {
  const ActiveTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('tasks').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;
                Color taskColor = Colors.blueAccent;
                var taskTag = data['taskTag'];

                if (taskTag == 'High') {
                  taskColor = Colors.orangeAccent;
                } else if (taskTag == 'Moderate') {
                  taskColor = Colors.greenAccent;
                }
                return TaskCard(
                  title: data['taskTitle'],
                  subtitle: data['taskDescription'],
                  subtitleDate: data['finalDate'],
                  color: taskColor,
                  editFunction: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                EditTaskScreen(taskId: document.id)));
                  },
                  deleteFunction: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return DeleteTaskScreen(taskId: document.id);
                        });
                  },
                  taskCompleteFunction: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return MarkTaskAsCompleted(taskId: document.id);
                        });
                  },
                );
              }).toList(),
            );
          } else {
            return Container(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        width: MediaQuery.sizeOf(context).width,
                        height: MediaQuery.sizeOf(context).height / 3,
                        child: Image.asset('/images/Nothing_to_find.png')),
                    const Text(
                      'You haven\'t created any tasks yet',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return const AddTask();
              });
        },
      ),
    ));
  }
}
