import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/utils/router/router_paths.dart';
import '../../../../../shared/models/product.dart';
import '../../manger/categories cubit/categories_cubit.dart';
import 'home_upper_part.dart';
import 'products_grid_view.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({
    super.key,
    required this.products,
  });
  final List<Product> products;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    //final count = products.length >= 30 ? 15 : (products.length + 1) / 2;
    double grideHeight = (width * .7) * products.length;
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 25),
          child: SizedBox(
            width: double.infinity,
            height: grideHeight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HomeUpperPart(),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 180,
                  child: CategoriesPart(),
                ),
                const SizedBox(height: 5),
                Text(
                  "New In",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    // fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: ProductsGridView(
                    products: products,
                    isScrollable: false,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

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
                // color: Theme.of(context).colorScheme.tertiary,
                fontSize: 22,
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
                  color: Theme.of(context).colorScheme.secondary,
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
        Expanded(
          child: CategoriesListView(
            categories: categories,
          ),
        ),
      ],
    );
  }
}

class CategoriesListView extends StatelessWidget {
  const CategoriesListView({super.key, required this.categories});
  final List<List<String>> categories;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      scrollDirection: Axis.horizontal,
      itemCount: categories[0].length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 60,
              width: 60,
              child: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.tertiary,
                child: Image.asset(
                  categories[1][index],
                  height: 35,
                ),
              ),
            ),
            SizedBox(
              width: 80,
              child: Text(
                textAlign: TextAlign.center,
                categories[0][index],
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
      ),
    );
  }
}
