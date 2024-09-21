import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:store_app/Features/authentication/data/domain/entity/user_entity.dart';
import 'package:store_app/utils/router/router_paths.dart';
import '../../../../utils/assets.dart';
import '../../../../utils/helper_extensions.dart';

import '../../../../shared/cubits/cubit/user_info_cubit.dart';
import '../../../../shared/cubits/cubit/user_info_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'widgets/custom_divider.dart';
import 'widgets/profile_info.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: UserScreenBody(),
      ),
    );
  }
}

class UserScreenBody extends StatefulWidget {
  const UserScreenBody({super.key});

  @override
  State<UserScreenBody> createState() => _UserScreenBodyState();
}

class _UserScreenBodyState extends State<UserScreenBody> {
  late UserEntity userInfo;
  @override
  void initState() {
    userInfo = context.read<UserInfoCubit>().user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserInfoCubit, UserInfoState>(
      builder: (context, state) {
        if (state is EditInfoState) {
          userInfo = state.user;
        }
        return ListView(
          children: [
            const SizedBox(
              height: 70,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ProfileInfo(
                userName: userInfo.userName,
                gmail: userInfo.email,
              ),
            ),
            const SizedBox(height: 15),
            const CustomDivider(
              dividerName: " Info ",
            ),
            const SizedBox(height: 10),

            const InfoCardWidget(
              infoName: "Address",
            ),
            const InfoCardWidget(
              infoName: "Payment",
            ),
            const InfoCardWidget(
              infoName: "Help",
            ),
            const InfoCardWidget(
              infoName: "Support",
            ),
            const SizedBox(height: 25),
            const Align(
              alignment: Alignment.center,
              child: SignOutButton(),
            ),
            const SizedBox(height: 20),

            //////////////////////////////////////////////////////////////////////////////////////
          ],
        );
      },
    );
  }
}

class SignOutButton extends StatefulWidget {
  const SignOutButton({
    super.key,
  });

  @override
  State<SignOutButton> createState() => _SignOutButtonState();
}

class _SignOutButtonState extends State<SignOutButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        await FirebaseAuth.instance.signOut();
        if (context.mounted) {
          Navigator.pushReplacementNamed(context, KRouter.authPage,
              arguments: 1);
        }
      },
      child: const Text(
        "Sign Out",
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          color: Colors.red,
        ),
      ),
    );
  }
}

class InfoCardWidget extends StatelessWidget {
  const InfoCardWidget({super.key, required this.infoName});
  final String infoName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Card(
        margin: EdgeInsets.zero,
        color: context.neutralColor(),
        elevation: 10,
        shadowColor: context.accentColor().withOpacity(.05),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                infoName,
                style: const TextStyle(
                  fontSize: 24,
                ),
              ),
              SvgPicture.asset(
                AssetsImages.arrow,
                height: 20,
                colorFilter: ColorFilter.mode(
                  context.accentColor(),
                  BlendMode.srcIn,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  //   child: ThemeSwitch(
                  //     lightTheme: userInfo.lightThem,
                  //   ),
                  // ),