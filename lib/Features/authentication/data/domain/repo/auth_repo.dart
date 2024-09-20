import 'package:dartz/dartz.dart';
import '../entity/user_entity.dart';
import '../../models/user_model.dart';
import '../../../../../utils/errors/failure.dart';
import '../../../../../utils/services/firebase_auth_services.dart';

class AuthRepo {
  final FirebaseAuthServices firebaseAuthServices;

  AuthRepo({required this.firebaseAuthServices});

  Future<Either<Failure, UserEntity>> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String userName,
  }) async {
    try {
      final user = await firebaseAuthServices.createUserWithEmailAndPassword(
        emailAddress: email,
        password: password,
        userName: userName,
      );
      return right(UserModel.fromFirebase(user));
    } catch (e) {
      return left(
        ServerFailure(
          e.toString(),
        ),
      );
    }
  }

  Future<Either<Failure, UserEntity>> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final user = await firebaseAuthServices.logInWithEmailAndPassword(
        emailAddress: email,
        password: password,
      );
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
      return left(
        ServerFailure(e.toString()),
      );
    }
  }

  Future<Either<Failure, Unit>> sendVerificationEmail() async {
    try {
      await firebaseAuthServices.sendVerificationEmail();
      return right(unit);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, Unit>> sendPasswordResetEmail(
      {required String email}) async {
    try {
      await firebaseAuthServices.sendPasswordResetEmail(email: email);
      return right(unit);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
