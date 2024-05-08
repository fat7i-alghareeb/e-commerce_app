import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../utils/assets.dart';
import '../../utils/router/router_paths.dart';
import '../../Features/products display(home)/presentation/manger/products cubit/products_cubit.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.title,
  });

  final String title;
  @override
  Widget build(BuildContext context) {
    final y = MediaQuery.of(context).size.height;
    //final x = MediaQuery.of(context).size.width;
    return SliverAppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: y / 10,
      centerTitle: false,
      elevation: 0,
      floating: true,
      title: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).colorScheme.tertiary,
          fontSize: 30,
          fontStyle: FontStyle.italic,
        ),
      ),
      actions: [
        Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, KRouter.searchScreen,
                    arguments:
                        BlocProvider.of<ProductsCubit>(context).products);
                HapticFeedback.heavyImpact();
              },
              icon: Icon(
                Icons.search,
                color: Theme.of(context).colorScheme.tertiary,
                size: 32,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            IconButton(
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
              icon: Image.asset(
                AssetsImages.menu,
                height: 32,
                color: Theme.of(context).colorScheme.tertiary,
              ),
            )
          ],
        )
      ],
    );
  }
}
