import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/utils/helper_extensions.dart';

import '../../../../../shared/cubits/cubit/user_info_cubit.dart';

class ThemeSwitch extends StatefulWidget {
  const ThemeSwitch({
    super.key,
    required this.lightTheme,
  });
  final bool lightTheme;
  @override
  State<ThemeSwitch> createState() => _ThemeSwitchState();
}

class _ThemeSwitchState extends State<ThemeSwitch> {
  late bool lightTheme;

  @override
  void initState() {
    lightTheme = widget.lightTheme;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Theme ",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: context.neutralColor(),
          ),
        ),
        Switch(
          value: !lightTheme,

          activeColor: Colors.white,
          inactiveThumbColor: context.accentColor(), //
          inactiveTrackColor: Colors.white,
          activeTrackColor: context.onPrimaryColor(), //
          onChanged: (value) {
            setState(() {
              lightTheme = !value;
              BlocProvider.of<UserInfoCubit>(context).changeTheme();
            });
          },
        ),
      ],
    );
  }
}
