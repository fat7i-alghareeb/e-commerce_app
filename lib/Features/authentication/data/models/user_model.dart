import 'package:firebase_auth/firebase_auth.dart';

import '../domain/entity/user_entity.dart';

class UserModel extends UserEntity {
  UserModel(
      {required super.userName, required super.email, required super.uId});

  factory UserModel.fromFirebase(User user) {
    return UserModel(
        userName: user.displayName ?? "Null",
        email: user.email ?? "Null",
        uId: user.uid);
  }
}
