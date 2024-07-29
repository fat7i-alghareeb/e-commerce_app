import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repo/search_repo.dart';
import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this.searchRepo) : super(SearchInitial());
  final SearchRepo searchRepo;

  Future<void> fetchProducts({required String searchText}) async {
    emit(SearchLoading());
    Map<String, dynamic> queries = {'q': searchText};
    queries.addAll(
        {"sortBy": SearchConstants.sortByTypes[SearchConstants.sortByIndex]});
    //queries.addAll({"limit": 10});
    var result = await searchRepo.fetchSearchedProducts(queries: queries);
    result.fold(
      (failure) {
        emit(SearchFailure(message: failure.message));
      },
      (apiResponse) {
        emit(
          SearchSuccess(apiResponse: apiResponse),
        );
      },
    );
  }
}

class SearchConstants {
  static List<String> sortByTypes = [
    "title",
    "rating",
    "price",
  ];
  static int sortByIndex = 0;
}
