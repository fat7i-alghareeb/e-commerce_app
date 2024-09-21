import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../Features/authentication/data/domain/entity/user_entity.dart';
import 'user_info_state.dart';

class UserInfoCubit extends Cubit<UserInfoState> {
  UserInfoCubit() : super(UserInfoInitial());
  final userBox = Hive.box<UserEntity>("user_box");
  // late bool _userTheme;
  Future<void> saveUser({required UserEntity userEntity}) async {
    if (userBox.isNotEmpty) {
      await userBox.putAt(0, userEntity);
    } else {
      await userBox.add(userEntity);
    }
  }

  get isDarkTheme {
    if (userBox.isNotEmpty) {
      return user.isDarkTheme;
    } else {
      return false;
    }
  }

  UserEntity get user => userBox.getAt(0)!;
  void changeTheme(bool newTheme) {
    user.isDarkTheme = newTheme;
    log(user.isDarkTheme.toString());
    userBox.putAt(0, user);

    emit(EditThemeUserInfo());
  }

  // void changeInfo({String? userName, String? gmail, String? password}) {
  //   final UserEntity newUserInfo = UserEntity(
  //     userName: userName ?? _user.userName,
  //     email: gmail ?? _user.email,
  //     uId: ,
  //     isDarkTheme: _user.isDarkTheme,
  //   );

  //   userBox.putAt(0, newUserInfo);
  //   _user = userBox.getAt(0)!;
  //   emit(EditInfoState(user: _user));
  // }
}
