import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:script_05_task_tracker_app/screens/initial/login_screen.dart';
import 'package:script_05_task_tracker_app/widgets/widget_export.dart';

class LogOutDialogue extends StatefulWidget {
  const LogOutDialogue({super.key});

  @override
  State<LogOutDialogue> createState() => _LogOutDialogueState();
}

class _LogOutDialogueState extends State<LogOutDialogue> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      content: SizedBox(
        height: MediaQuery.sizeOf(context).height / 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height / 4,
              child: Image.asset('/images/log_out.jpg'),
            ),
          ],
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 24.0),
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.redAccent,
          ),
          child: ReusableButton(
              label: 'Log Out',
              navigatorFunction: () {
                FirebaseAuth.instance.signOut().then((value) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const LogIn()));
                });
              }),
        ),
      ],
    );
  }
}
