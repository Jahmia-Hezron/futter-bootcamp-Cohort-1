import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  const TaskCard(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.color,
      required this.editFunction,
      required this.deleteFunction,
      required this.taskCompleteFunction,
      required this.subtitleDate});

  final String title;
  final String subtitle;
  final Color color;
  final String subtitleDate;
  final dynamic editFunction;
  final dynamic deleteFunction;
  final dynamic taskCompleteFunction;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 18.0),
      padding: const EdgeInsets.symmetric(vertical: 14.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Theme.of(context).cardColor,
        boxShadow: const [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 6.0,
            offset: Offset(0, 3.0),
          ),
        ],
      ),
      child: ListTile(
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 12.0,
              height: 12.0,
              child: CircleAvatar(
                backgroundColor: color,
              ),
            ),
          ],
        ),
        title: Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(subtitle),
            Divider(
              thickness: 2.0,
              color: Theme.of(context).highlightColor,
            ),
            Text(
              'Deadline:  $subtitleDate',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        isThreeLine: true,
        dense: true,
        trailing: PopupMenuButton(
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                value: '1',
                onTap: editFunction,
                child: const Text('Edit'),
              ),
              PopupMenuItem(
                value: '2',
                onTap: deleteFunction,
                child: const Text('Delete'),
              ),
              PopupMenuItem(
                value: '3',
                onTap: taskCompleteFunction,
                child: const Text('Mark as Done'),
              ),
            ];
          },
        ),
      ),
    );
  }
}
