import '../../models/user.dart';

abstract class UserInfoState {}

final class UserInfoInitial extends UserInfoState {}

final class EditThemeUserInfo extends UserInfoState {}

final class EditInfoState extends UserInfoState {
  final User user;

  EditInfoState({required this.user});
}
