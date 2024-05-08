import '../../models/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'user_info_state.dart';

class UserInfoCubit extends Cubit<UserInfoState> {
  UserInfoCubit() : super(UserInfoInitial());
  final userBox = Hive.box<User>("user_box");
  late bool _userTheme;
  late User _user = userBox.getAt(0)!;
  Future<void> saveUser(
      {required String userName,
      required String gmail,
      required String password}) async {
    final User user = User(
      userName: userName,
      gmail: gmail,
      password: password,
      lightThem: true,
    );
    _user = user;
    await userBox.add(user);
  }

  get userTheme {
    if (userBox.isNotEmpty) {
      _userTheme = _user.lightThem;
    } else {
      _userTheme = true;
    }
    return _userTheme;
  }

  get user => _user;

  void changeTheme() {
    _user.lightThem = !_userTheme;
    userBox.putAt(0, user);
    _user = userBox.getAt(0)!;
    _userTheme = !_userTheme;
    emit(EditThemeUserInfo());
  }

  void changeInfo({String? userName, String? gmail, String? password}) {
    final User newUserInfo = User(
      userName: userName ?? _user.userName,
      gmail: gmail ?? _user.gmail,
      password: password ?? _user.password,
      lightThem: _user.lightThem,
    );

    userBox.putAt(0, newUserInfo);
    _user = userBox.getAt(0)!;
    emit(EditInfoState(user: _user));
  }
}
