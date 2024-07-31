import 'package:flutter/material.dart';

extension ColorScheme on BuildContext {
  Color primaryColor() => Theme.of(this).colorScheme.primary;
  Color onPrimaryColor() => Theme.of(this).colorScheme.onPrimary;
  Color accentColor() => Theme.of(this).colorScheme.secondary;
  Color neutralColor() => Theme.of(this).colorScheme.tertiary;
}
