import 'package:flutter/material.dart';

class NavigatorIcon extends StatelessWidget {
  final VoidCallback setChange;
  final bool changing;
  final IconData icon;
  const NavigatorIcon({
    super.key,
    required this.setChange,
    required this.changing,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: setChange,
        child: Container(
          color: Colors.transparent,
          padding:
              changing ? const EdgeInsets.only(bottom: 5) : EdgeInsets.zero,
          child: Center(
            child: Icon(
              icon,
              color: changing
                  ? Theme.of(context).colorScheme.secondary
                  : Theme.of(context).colorScheme.secondary.withOpacity(0.1),
              size: changing ? 40 : 30,
            ),
          ),
        ),
      ),
    );
  }
}
