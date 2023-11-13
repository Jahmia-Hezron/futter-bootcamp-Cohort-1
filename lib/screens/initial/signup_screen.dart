import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:script_05_task_tracker_app/screens/screens_export.dart';
import 'package:script_05_task_tracker_app/widgets/widget_export.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  ScaffoldMessengerState? scaffoldMessengerState;

  @override
  void initState() {
    super.initState();
  }

  Future<void> signInAnonymously() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInAnonymously();
      User? user = userCredential.user;
      scaffoldMessengerState?.showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          elevation: 18.0,
          content: Text('Signed in anonymously: ${user!.uid}')));
    } catch (e) {
      scaffoldMessengerState?.showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          elevation: 18.0,
          content: Text('Failed to sign in anonymously: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          'Sign Up',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height / 2.8,
              child: Image.asset('/images/Placeholder.gif')),
          SizedBox(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height / 2.2,
            child: ListView(
              padding: const EdgeInsets.symmetric(
                horizontal: 48.0,
              ),
              children: [
                ReusableFormField(
                    controller: userNameController, hintText: 'UserName'),
                ReusableFormField(
                    controller: emailController, hintText: 'E-mail'),
                ReusableFormField(
                    controller: passwordController, hintText: 'Password'),
                ReusableFormField(
                    controller: confirmPasswordController,
                    hintText: 'Confirm Password'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text('Already have an account?'),
                    const SizedBox(width: 10.0),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LogIn()),
                        );
                      },
                      child: const MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: Text(
                          'Sign In',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: ReusableButton(
            label: 'Create Account',
            textColor: Theme.of(context).primaryColor,
            navigatorFunction: () {
              if (userNameController.text.isNotEmpty &&
                  emailController.text.isNotEmpty &&
                  passwordController.text.isNotEmpty &&
                  confirmPasswordController.text.isNotEmpty) {
                FirebaseAuth.instance
                    .createUserWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text)
                    .then((value) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Theme.of(context).primaryColor,
                      content: const Text('Account Created Successfully')));
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const LogIn()));
                }).onError((error, stackTrace) {});
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Theme.of(context).primaryColor,
                    content: const Text('Fill all Fields')));
              }
            }),
      ),
    ));
  }
}
