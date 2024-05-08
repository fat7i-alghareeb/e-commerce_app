import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../products display(home)/presentation/view/widgets/products_grid_view.dart';
import '../../../../shared/models/product.dart';
import '../../../products display(home)/presentation/manger/products cubit/products_cubit.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            HapticFeedback.heavyImpact();
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Theme.of(context).colorScheme.tertiary,
          ),
        ),
        title: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Theme.of(context).colorScheme.tertiary.withOpacity(.1),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: Icon(
                    Icons.search,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    controller: _searchController,
                    cursorColor: Theme.of(context).colorScheme.tertiary,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter product name',
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: ProductsGridView(
        products: _filteredProducts,
        isScrollable: true,
      ),
    );
  }
}
