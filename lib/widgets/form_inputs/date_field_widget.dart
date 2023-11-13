import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReusableDateField extends StatefulWidget {
  const ReusableDateField({
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
  State<ReusableDateField> createState() => _ReusableDateFieldState();
}

class _ReusableDateFieldState extends State<ReusableDateField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 28.0),
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
              DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2020),
                  lastDate: DateTime(3005));
              if (pickedDate != null) {
                String formattedDate =
                    DateFormat('yyy-MM-dd').format(pickedDate);
                setState(() {
                  widget.controller.text = formattedDate;
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
      ),
    );
  }
}
