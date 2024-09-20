part of 'log_in_cubit.dart';

@immutable
sealed class LogInState {}

final class LogInInitial extends LogInState {}

final class LogInLoading extends LogInState {}

final class LogInSuccess extends LogInState {
  final UserEntity userEntity;

  LogInSuccess({required this.userEntity});
}

final class LogInFailure extends LogInState {
  final String message;

  LogInFailure({required this.message});
}

final class LogInPasswordResetFailure extends LogInState {
  final String message;

  LogInPasswordResetFailure({required this.message});
}

class LogInPasswordResetSent extends LogInState {
  final String message;

  LogInPasswordResetSent({required this.message});
}
