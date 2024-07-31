import 'package:flutter/material.dart';
import 'package:store_app/Features/Navigator/presentation/view/widgets/drawer%20widgets/theme_switch.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({
    super.key,
  });

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double x = MediaQuery.of(context).size.width;
    return Drawer(
      width: x * 0.7,
      child: const SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              ThemeSwitch(),
            ],
          ),
        ),
      ),
    );
  }
}
