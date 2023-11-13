import 'package:flutter/material.dart';

class ReusableTimeField extends StatefulWidget {
  const ReusableTimeField({
    super.key,
    required this.controller,
    required this.hintText,
    this.lable = "Default",
    this.textLines = 1,
  });

  final TextEditingController controller;
  final String hintText;
  final String lable;
  final int textLines;

  @override
  State<ReusableTimeField> createState() => _ReusableTimeFieldState();
}

class _ReusableTimeFieldState extends State<ReusableTimeField> {
  TimeOfDay timeOfDay = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 28.0),
              child: Text(
                widget.lable,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            TextField(
              controller: widget.controller,
              textInputAction: TextInputAction.send,
              readOnly: true,
              onTap: () async {
                TimeOfDay? selectedTime = await showTimePicker(
                    context: context,
                    initialTime: timeOfDay,
                    initialEntryMode: TimePickerEntryMode.dial);
                if (selectedTime != null) {
                  String finalTime = '${timeOfDay.hour} : ${timeOfDay.minute}';
                  setState(() {
                    widget.controller.text = finalTime;
                  });
                }
              },
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 24.0),
                  hintText: widget.hintText,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(08.0),
                    borderSide: BorderSide(
                        color: Theme.of(context).highlightColor, width: 2.0),
                  )),
            ),
          ],
        ));
  }
}
