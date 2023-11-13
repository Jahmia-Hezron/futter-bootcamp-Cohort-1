import 'package:flutter/material.dart';

class ReusableFormField extends StatelessWidget {
  const ReusableFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.label,
    this.textLines = 1,
  });

  final TextEditingController controller;
  final String hintText;
  final String? label;
  final int textLines;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (label != null) // Only show the label if it is not null
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 28.0),
                child: Text(
                  label!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            TextField(
              keyboardType: TextInputType.multiline,
              maxLines: textLines,
              controller: controller,
              textInputAction: TextInputAction.send,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 24.0),
                  hintText: hintText,
                  filled: true,
                  fillColor: Theme.of(context).focusColor,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                        color: Theme.of(context).highlightColor, width: 2.0),
                  )),
            ),
          ],
        ));
  }
}
