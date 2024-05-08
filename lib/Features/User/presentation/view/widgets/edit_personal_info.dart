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
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.personalInfoName,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.tertiary,
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
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ),
        ],
      ),
    );
  }
}
