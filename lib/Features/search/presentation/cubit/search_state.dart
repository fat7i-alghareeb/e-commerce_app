import '../../../../shared/models/api_response.dart';

abstract class SearchState {}

final class SearchInitial extends SearchState {}

final class SearchSuccess extends SearchState {
  final ApiResponse apiResponse;

  SearchSuccess({required this.apiResponse});
}

final class SearchFailure extends SearchState {
  final String message;

  SearchFailure({required this.message});
}

final class SearchLoading extends SearchState {}
