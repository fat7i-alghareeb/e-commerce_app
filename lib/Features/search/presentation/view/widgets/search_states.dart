import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/utils/assets.dart';

import '../../../../../shared/widgets/products_grid_view.dart';
import '../../cubit/search_cubit.dart';
import '../../cubit/search_state.dart';

class SearchStates extends StatelessWidget {
  const SearchStates({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        if (state is SearchSuccess) {
          return ProductSliverGrid(
            products: state.apiResponse.products ?? [],
          );
        } else if (state is SearchFailure) {
          return SliverFillRemaining(
            child: Center(
              child: Text(state.message),
            ),
          );
        } else if (state is SearchLoading) {
          return SliverFillRemaining(
            child: Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          );
        } else {
          return SliverFillRemaining(
            child: Center(
              child: Image.asset(
                AssetsImages.searchPng,
                height: 140,
              ),
            ),
          );
        }
      },
    );
  }
}
