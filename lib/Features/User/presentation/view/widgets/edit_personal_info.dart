import 'package:flutter/material.dart';

import 'dialog_widget.dart';

class EditPersonalInfoWidget extends StatefulWidget {
  const EditPersonalInfoWidget({
    super.key,
    required this.personalInfoName,
    required this.controller,
    required this.onPressed,
  });
  final String personalInfoName;
  final void Function(String newInfo) onPressed;
  final TextEditingController controller;

  @override
  State<EditPersonalInfoWidget> createState() => _EditPersonalInfoWidgetState();
}

class _EditPersonalInfoWidgetState extends State<EditPersonalInfoWidget> {
  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
      child: Card(
        margin: EdgeInsets.zero,
        color: Theme.of(context).colorScheme.tertiary,
        elevation: 10,
        shadowColor: Theme.of(context).colorScheme.secondary.withOpacity(.05),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.personalInfoName,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialogWidget(
                      onPressed: widget.onPressed,
                      title: 'Edit your tasks',
                      controller: widget.controller,
                    ),
                  );
                },
                icon: Icon(
                  Icons.settings,
                  size: 32,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
