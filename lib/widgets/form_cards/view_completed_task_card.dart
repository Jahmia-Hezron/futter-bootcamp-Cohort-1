import 'package:flutter/material.dart';

class ViewCompletedTaskCard extends StatelessWidget {
  const ViewCompletedTaskCard({
    super.key,
    required this.taskDescription,
    required this.taskData,
    required this.cardWidth,
  });

  final String taskDescription;
  final String taskData;
  final dynamic cardWidth;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: cardWidth,
          margin: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 28.0),
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Text(
            taskDescription,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          width: cardWidth,
          margin: const EdgeInsets.symmetric(horizontal: 28.0),
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 14.0),
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
          child: Text(taskData),
        )
      ],
    );
  }
}
