import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../utils/helper_extensions.dart';

import '../../../../../../utils/router/router_paths.dart';
import '../../../manger/categories cubit/categories_cubit.dart';
import 'categories_list_view.dart';

class CategoriesPart extends StatefulWidget {
  const CategoriesPart({super.key});

  @override
  State<CategoriesPart> createState() => _CategoriesPartState();
}

class _CategoriesPartState extends State<CategoriesPart> {
  List<List<String>> categories = [];
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CategoriesCubit>(context).setCategories();
    categories = BlocProvider.of<CategoriesCubit>(context).categories;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Categories",
              style: TextStyle(
                // color: context.neutralColor(),
                fontSize: 30,
                fontFamily: "caveat",
                fontWeight: FontWeight.w900,
                // fontStyle: FontStyle.italic,
              ),
            ),
            TextButton(
              onPressed: () => Navigator.pushNamed(
                context,
                KRouter.categoriesListScreen,
              ),
              child: Text(
                "See All",
                style: TextStyle(
                  color: context.accentColor(),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  // fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 120,
          child: CategoriesListView(
            categories: categories,
          ),
        ),
      ],
    );
  }
}
