import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:store_app/shared/widgets/app_icon.dart';
import 'package:store_app/shared/widgets/sliver_sized_box.dart';
import 'package:store_app/utils/assets.dart';

import '../../../../shared/models/product.dart';
import '../../../../shared/widgets/products_grid_view.dart';
import '../../../products_display_home/presentation/manger/products cubit/products_cubit.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key, required this.products});
  final List<Product> products;
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();
  List<Product> _filteredProducts = [];

  @override
  void initState() {
    _filteredProducts = BlocProvider.of<ProductsCubit>(context).products;
    _searchController.addListener(_onSearchChanged);
    super.initState();
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    String searchText = _searchController.text.toLowerCase();
    setState(
      () {
        if (searchText.isNotEmpty) {
          _filteredProducts = widget.products
              .where(
                  (product) => product.title.toLowerCase().contains(searchText))
              .toList();
        } else {
          _filteredProducts = [];
        }
      },
    );
  }

//todo add clear button to textfield
//todo add filter row
//todo refactor the code
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 15,
            right: 15,
            top: 20,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  AppIcon(
                    widget: SvgPicture.asset(
                      AssetsImages.backArrow,
                      height: 20,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      HapticFeedback.heavyImpact();
                    },
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(26),
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: SizedBox(
                              width: 20,
                              height: 20,
                              child: SvgPicture.asset(
                                AssetsImages.search,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: TextField(
                                controller: _searchController,
                                cursorColor:
                                    Theme.of(context).colorScheme.tertiary,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Enter product name',
                                  hintStyle: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey.withOpacity(0.5),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    ProductSliverGrid(
                      products: _filteredProducts,
                    ),
                    const SliverSizedBox(
                      height: 50,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
