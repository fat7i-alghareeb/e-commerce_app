import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../manger/categories cubit/categories_cubit.dart';
import 'widgets/categories_list_screen_body.dart';

class CategoriesListScreen extends StatefulWidget {
  const CategoriesListScreen({super.key});

  @override
  State<CategoriesListScreen> createState() => _CategoriesListScreenState();
}

class _CategoriesListScreenState extends State<CategoriesListScreen> {
  List<List<String>> categories = [];
  @override
  void initState() {
    context.read<CategoriesCubit>().setCategories();
    categories = context.read<CategoriesCubit>().categories;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CategoriesListBody(categories: categories),
      ),
    );
  }
}
