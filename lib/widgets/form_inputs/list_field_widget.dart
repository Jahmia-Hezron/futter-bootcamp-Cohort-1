import 'package:flutter/material.dart';

class ReusableListField extends StatefulWidget {
  const ReusableListField({
    super.key,
    required this.listItems,
    required this.listHint,
    required this.controller,
    this.lable = "Default",
  });

  final List listItems;
  final String listHint;
  final String lable;
  final TextEditingController controller;

  @override
  State<ReusableListField> createState() => _ReusableListFieldState();
}

class _ReusableListFieldState extends State<ReusableListField> {
  @override
  void initState() {
    super.initState();
    widget.controller.text =
        widget.listItems.first; // Initialize with the first item
  }

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
          DropdownButtonFormField(
            hint: Text(
              widget.listHint,
            ),
            items: widget.listItems.map((item) {
              return DropdownMenuItem(
                  value: item,
                  child: Text(
                    item,
                  ));
            }).toList(),
            onChanged: (dynamic newValue) {
              setState(() {
                widget.controller.text = newValue!;
              });
            },
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 24.0),
                filled: true,
                fillColor: Theme.of(context).focusColor,
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
