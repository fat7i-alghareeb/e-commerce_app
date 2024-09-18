import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../manger/signIn/sign_in_cubit.dart';
import '../../../../utils/service_locator.dart';
import 'widgets/verification screen widgets/verification_body.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<SignInCubit>(),
      child: PopScope(
        onPopInvokedWithResult: (didPop, result) async {
          if (didPop) {
            log("fuck");
            final user = FirebaseAuth.instance.currentUser;
            await user?.delete();
          }
        },
        child: const Scaffold(
          body: SafeArea(
            child: VerificationBody(),
          ),
        ),
      ),
    );
  }
}
