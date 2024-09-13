import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:store_app/Features/authentication/data/domain/entity/user_entity.dart';
import 'package:store_app/Features/authentication/data/models/user_model.dart';
import 'package:store_app/utils/errors/failure.dart';
import 'package:store_app/utils/services/firebase_auth_services.dart';

class AuthRepo {
  final FirebaseAuthServices firebaseAuthServices;

  AuthRepo({required this.firebaseAuthServices});

  Future<Either<Failure, UserEntity>> createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final user = await firebaseAuthServices.createUserWithEmailAndPassword(
          emailAddress: email, password: password);
      return right(UserModel.fromFirebase(user));
    } catch (e) {
      return left(
        ServerFailure(
          e.toString(),
        ),
      );
    }
  }

  Future<Either<Failure, UserEntity>> signInWithGoogle() async {
    try {
      final user = await firebaseAuthServices.signInWithGoogle();
      return right(UserModel.fromFirebase(user));
    } catch (e) {
      log(e.toString());
      return left(
        ServerFailure(
          e.toString(),
        ),
      );
    }
  }
}
