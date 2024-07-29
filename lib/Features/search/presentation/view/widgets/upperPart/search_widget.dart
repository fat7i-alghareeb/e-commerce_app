import 'package:flutter/material.dart';

import 'custom_text_field.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({
    super.key,
  });

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final _searchController = TextEditingController();
  final _searchFocusNode = FocusNode();
  @override
  void initState() {
    _searchController.addListener(_onSearchChanged);
    super.initState();
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchFocusNode.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    _searchController.text.length == 1 || _searchController.text.isEmpty
        ? setState(() {})
        : null;
  }

  Widget _cancelWidget() {
    return _searchController.text.isEmpty
        ? const SizedBox.shrink()
        : GestureDetector(
            onTap: () => _searchController.clear(),
            child: const Padding(
              padding: EdgeInsets.only(left: 15),
              child: Center(
                child: Text("Cancel"),
              ),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomTextField(
            searchController: _searchController,
            searchFocusNode: _searchFocusNode,
          ),
        ),
        _cancelWidget(),
      ],
    );
  }
}
