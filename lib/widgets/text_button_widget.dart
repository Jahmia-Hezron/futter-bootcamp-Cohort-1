import 'package:flutter/material.dart';

class ReusableButton extends StatelessWidget {
  const ReusableButton({
    super.key,
    required this.label,
    required this.navigatorFunction,
    this.textColor = Colors.white,
  });

  final String label;
  final Color textColor;
  final dynamic navigatorFunction;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: navigatorFunction,
        child: Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold, color: textColor),
        ));
  }
}
