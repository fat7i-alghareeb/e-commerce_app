import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/Features/search/data/repo/search_repo.dart';
import 'package:store_app/Features/search/presentation/view/widgets/search_states.dart';
import 'package:store_app/shared/widgets/sliver_sized_box.dart';
import '../../../../utils/service_locator.dart';
import '../cubit/search_cubit.dart';
import 'widgets/number_of_results.dart';
import 'widgets/upperPart/search_upper_part.dart';
import 'widgets/sort_by_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
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
    return const Padding(
      padding: EdgeInsets.only(
        left: 15,
        right: 15,
        top: 20,
      ),
      child: CustomScrollView(
        slivers: [
          SearchUpperPart(),
          SliverSizedBox(height: 20),
          SortByWidget(),
          SliverSizedBox(height: 20),
          NumberOfResults(),
          SliverSizedBox(height: 20),
          SearchStates(),
        ],
      ),
    );
  }
}
