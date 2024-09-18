import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../utils/helper_extensions.dart';

import '../../../../../../shared/cubits/cubit/user_info_cubit.dart';

class ThemeSwitch extends StatefulWidget {
  const ThemeSwitch({
    super.key,
  });
  @override
  State<ThemeSwitch> createState() => _ThemeSwitchState();
}

class _ThemeSwitchState extends State<ThemeSwitch> {
  late bool lightTheme;

  @override
  void initState() {
    lightTheme = BlocProvider.of<UserInfoCubit>(context).userTheme;
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
            color: context.onPrimaryColor(),
          ),
        ),
        Switch(
          value: !lightTheme,

          activeColor: context.onPrimaryColor(),
          inactiveThumbColor: context.accentColor(), //
          inactiveTrackColor: context.primaryColor(),
          activeTrackColor: context.accentColor(), //
          onChanged: (value) {
            setState(
              () {
                lightTheme = !value;
                BlocProvider.of<UserInfoCubit>(context).changeTheme();
              },
            );
          },
        ),
      ],
    );
  }
}
