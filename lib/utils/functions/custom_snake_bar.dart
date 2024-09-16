import 'package:flutter/material.dart';

void customSnakeBar({
  required BuildContext context,
  required String text,
  required Color color,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 2),
      content: Text(text),
      backgroundColor: color,
      padding: const EdgeInsets.all(25),
    ),
  );
}
