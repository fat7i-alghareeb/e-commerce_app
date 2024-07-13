import 'package:flutter/material.dart';

class AlertDialogWidget extends StatefulWidget {
  final String title;
  final void Function(String newInfo) onPressed;
  final TextEditingController controller;
  const AlertDialogWidget({
    super.key,
    required this.title,
    required this.onPressed,
    required this.controller,
  });

  @override
  State<AlertDialogWidget> createState() => _AlertDialogWidgetState();
}

class _AlertDialogWidgetState extends State<AlertDialogWidget> {
  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  bool isValid = true;
//todo fixing focus when keyboard closed
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(10),
      backgroundColor: Theme.of(context).colorScheme.primary,
      title: const Text(
        "Update your Info",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: TextField(
        controller: widget.controller,
        cursorColor: Theme.of(context).colorScheme.tertiary,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: () {
              widget.controller.clear();
              setState(() {});
            },
            icon: Icon(
              Icons.clear_rounded,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          filled: true,
          fillColor: Colors.transparent,
          hintText: "Enter new info",
          hintStyle: TextStyle(
            fontSize: 13,
            color: Theme.of(context).colorScheme.tertiary,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.secondary,
              width: 4,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(6)),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.tertiary,
              width: 2,
            ),
          ),
          errorText: isValid ? null : "Please enter a value",
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            if (widget.controller.text.isNotEmpty) {
              widget.onPressed(widget.controller.text);
            } else {
              setState(() {
                isValid = false;
              });
            }
          },
          child: const Text(
            "Edit",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
