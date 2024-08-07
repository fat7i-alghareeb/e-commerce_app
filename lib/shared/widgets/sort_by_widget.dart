import 'package:flutter/material.dart';

import '../../Features/search/presentation/cubit/search_cubit.dart';
import '../../Features/search/presentation/view/widgets/sort_type_widget.dart';

class SortByWidget extends StatefulWidget {
  const SortByWidget({
    super.key,
  });

  @override
  State<SortByWidget> createState() => _SortByWidgetState();
}

class _SortByWidgetState extends State<SortByWidget> {
  void _changeType(int index) {
    setState(
      () {
        SearchConstants.sortByIndex = index;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Row(
      children: [
        const Text("Sort By: "),
        Expanded(
          child: SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.zero,
              itemCount: SearchConstants.sortByTypes.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () => _changeType(index),
                child: SortTypeWidget(
                  typeName: SearchConstants.sortByTypes[index],
                  isSelected: SearchConstants.sortByIndex == index,
                ),
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
