import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../utils/router/router_paths.dart';
import '../drawer%20widgets/categories_card_widget.dart';

import '../../../../../products display(home)/presentation/manger/categories cubit/categories_cubit.dart';
import '../../../../../../utils/constants.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({
    super.key,
  });

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  List<List<String>> categories = [];
  @override
  void initState() {
    super.initState();
    categories = BlocProvider.of<CategoriesCubit>(context).categories;
  }

  @override
  Widget build(BuildContext context) {
    double x = MediaQuery.of(context).size.width;
    return Drawer(
      width: x * 0.7,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  if (selectedIndex == -1) {
                    Scaffold.of(context).closeEndDrawer();
                    HapticFeedback.heavyImpact();
                  } else {
                    selectedIndex = -1;
                    Navigator.pushReplacementNamed(
                        context, KRouter.mainNavigator);
                    HapticFeedback.heavyImpact();
                  }
                },
                child: Card(
                  color: -1 == selectedIndex
                      ? Theme.of(context).colorScheme.secondary
                      : Theme.of(context).colorScheme.primary.withOpacity(0.8),
                  elevation: 2,
                  child: SizedBox(
                    height: 90,
                    child: Center(
                      child: Text(
                        "HOME",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: -1 == selectedIndex
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Catagories:",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.italic,
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: categories[0].length,
                  itemBuilder: (context, index) {
                    return CategoriesCard(
                      name: categories[0][index],
                      image: categories[1][index],
                      isSelected: selectedIndex == index,
                      index: index,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
