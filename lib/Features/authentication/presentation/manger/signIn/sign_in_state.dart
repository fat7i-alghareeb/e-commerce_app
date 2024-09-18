import '../../../data/domain/entity/user_entity.dart';

class SignInState {}

final class SignInInitial extends SignInState {}

final class SignInLoading extends SignInState {}

final class SignInSuccess extends SignInState {
  final UserEntity userEntity;

  SignInSuccess({required this.userEntity});
}

final class SignInFailure extends SignInState {
  final String message;

  SignInFailure({required this.message});
}

final class SignInEmailVerificationFailure extends SignInState {
  final String message;

  SignInEmailVerificationFailure({required this.message});
}

final class SignInEmailVerificationSuccess extends SignInState {}
