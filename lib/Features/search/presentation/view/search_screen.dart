import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:store_app/Features/search/data/repo/search_repo.dart';
import 'package:store_app/Features/search/presentation/view/widgets/search_states.dart';
import 'package:store_app/shared/widgets/app_icon.dart';
import 'package:store_app/shared/widgets/sliver_sized_box.dart';
import 'package:store_app/utils/assets.dart';

import '../../../../utils/service_locator.dart';
import '../cubit/search_cubit.dart';
import '../cubit/search_state.dart';
import 'widgets/upperPart/search_upper_part.dart';
import 'widgets/sort_by_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
//todo add clear button to textfield
//todo add filter row
//todo refactor the code
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (context) => SearchCubit(getIt<SearchRepo>()),
          child: const SearchBody(),
        ),
      ),
    );
  }
}

class SearchBody extends StatelessWidget {
  const SearchBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 15,
        right: 15,
        top: 20,
      ),
      child: CustomScrollView(
        slivers: [
          const SearchUpperPart(),
          const SliverSizedBox(height: 20),
          const SortByWidget(),
          const SliverSizedBox(height: 20),
          BlocBuilder<SearchCubit, SearchState>(
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
          ),
          const SliverSizedBox(height: 20),
          const SearchStates(),
        ],
      ),
    );
  }
}
