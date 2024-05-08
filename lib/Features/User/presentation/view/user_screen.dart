import '../../../../shared/cubits/cubit/user_info_cubit.dart';
import '../../../../shared/cubits/cubit/user_info_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../shared/models/user.dart';
import 'widgets/custom_divider.dart';
import 'widgets/edit_personal_info.dart';
import 'widgets/profile_info.dart';
import 'widgets/theme_switch.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  late User userInfo;
  @override
  void initState() {
    userInfo = BlocProvider.of<UserInfoCubit>(context).user;
    super.initState();
  }

  void _changeInfo({String? userName, String? gmail, String? password}) {
    BlocProvider.of<UserInfoCubit>(context)
        .changeInfo(userName: userName, gmail: gmail, password: password);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 100),
          child: BlocBuilder<UserInfoCubit, UserInfoState>(
            builder: (context, state) {
              if (state is EditInfoState) {
                userInfo = state.user;
              }
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: ProfileInfo(
                      userName: userInfo.userName,
                      gmail: userInfo.gmail,
                    ),
                  ),
//////////////////////////////////////////////////////////////////////////////////////
                  const CustomDivider(
                    dividerName: "Personal Info",
                  ),
//////////////////////////////////////////////////////////////////////////////////////
                  EditPersonalInfoWidget(
                    personalInfoName: "User Name",
                    onPressed: (String newInfo) {
                      _changeInfo(userName: newInfo);
                    },
                    controller: TextEditingController(text: userInfo.userName),
                  ),
//////////////////////////////////////////////////////////////////////////////////////
                  EditPersonalInfoWidget(
                    personalInfoName: "Gmail",
                    controller: TextEditingController(text: userInfo.gmail),
                    onPressed: (String newInfo) {
                      _changeInfo(gmail: newInfo);
                    },
                  ),
//////////////////////////////////////////////////////////////////////////////////////
                  EditPersonalInfoWidget(
                    personalInfoName: "Password",
                    onPressed: (String newInfo) {
                      _changeInfo(password: newInfo);
                    },
                    controller: TextEditingController(),
                  ),
//////////////////////////////////////////////////////////////////////////////////////
                  const CustomDivider(
                    dividerName: "Settings",
                  ),
//////////////////////////////////////////////////////////////////////////////////////
                  const SizedBox(
                    height: 20,
                  ),
//////////////////////////////////////////////////////////////////////////////////////
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: ThemeSwitch(
                      lightTheme: userInfo.lightThem,
                    ),
                  )
//////////////////////////////////////////////////////////////////////////////////////
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
