import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/search_cubit.dart';
import '../../cubit/search_state.dart';

class NumberOfResults extends StatelessWidget {
  const NumberOfResults({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        if (state is SearchSuccess) {
          return SliverToBoxAdapter(
            child: Text(
              "Results Found (${state.apiResponse.products?.length ?? 0})",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
          );
        }
        return const SliverToBoxAdapter(child: SizedBox.shrink());
      },
    );
  }
}
