import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:script_05_task_tracker_app/export.dart';
import 'package:script_05_task_tracker_app/screens/screens_export.dart';
import 'package:script_05_task_tracker_app/widgets/widget_export.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final logInEmailController = TextEditingController();
  final logInPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          'Log In',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height / 2,
              child: Image.asset('/images/Password.gif')),
          SizedBox(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height / 3,
            child: ListView(
              padding: const EdgeInsets.symmetric(
                horizontal: 48.0,
              ),
              children: [
                ReusableFormField(
                  controller: logInEmailController,
                  hintText: 'E-mail',
                ),
                ReusableFormField(
                  controller: logInPasswordController,
                  hintText: 'Password',
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text('Do not have an account?'),
                    const SizedBox(width: 10.0),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUp()),
                        );
                      },
                      child: const MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: Text(
                          'Sign Up',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 24.0),
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Theme.of(context).primaryColor,
                  ),
                  child: ReusableButton(
                      label: 'Sign in Anonymous',
                      navigatorFunction: () {
                        FirebaseAuth.instance.signInAnonymously().then((value) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const AppHome()));
                        }).onError((error, stackTrace) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Theme.of(context).primaryColor,
                              behavior: SnackBarBehavior.floating,
                              elevation: 18.0,
                              content: const Text('Invalid email or password'),
                            ),
                          );
                        });
                      }),
                ),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: ReusableButton(
            label: 'Continue',
            textColor: Theme.of(context).primaryColor,
            navigatorFunction: () {
              if (logInPasswordController.text.isNotEmpty &&
                  logInEmailController.text.isNotEmpty) {
                FirebaseAuth.instance
                    .signInWithEmailAndPassword(
                        email: logInEmailController.text,
                        password: logInPasswordController.text)
                    .then((value) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const AppHome()));
                }).onError((error, stackTrace) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        backgroundColor: Theme.of(context).primaryColor,
                        behavior: SnackBarBehavior.floating,
                        elevation: 18.0,
                        content: const Text('Invalid email or password')),
                  );
                });
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Theme.of(context).primaryColor,
                    behavior: SnackBarBehavior.floating,
                    elevation: 18.0,
                    content: const Text('Fill all Fields'),
                  ),
                );
              }
            }),
      ),
    ));
  }
}
