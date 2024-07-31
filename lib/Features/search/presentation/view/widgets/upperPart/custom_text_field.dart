import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:store_app/utils/helper_extensions.dart';

import '../../../../../../utils/assets.dart';
import '../../../cubit/search_cubit.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required TextEditingController searchController,
    required this.searchFocusNode,
  }) : _searchController = searchController;

  final TextEditingController _searchController;
  final FocusNode searchFocusNode;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        color: context.neutralColor(),
        border: Border.all(
          color: searchFocusNode.hasFocus
              ? context.accentColor()
              : Colors.transparent,
        ),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                controller: _searchController,
                focusNode: searchFocusNode,
                onSubmitted: (value) {
                  if (value.isNotEmpty) {
                    BlocProvider.of<SearchCubit>(context)
                        .fetchProducts(searchText: value);
                  }
                },
                textInputAction: TextInputAction.search,
                cursorColor: context.neutralColor(),
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
    );
  }
}
