import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../shared/widgets/app_icon.dart';
import '../../../../../utils/assets.dart';
import '../../../../../utils/router/router_paths.dart';
import '../../manger/products cubit/products_cubit.dart';
import 'swiper_widget.dart';

class HomeUpperPart extends StatelessWidget {
  const HomeUpperPart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const SwiperWidget(),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 30, 10, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AppIcon(
                opacity: .15,
                onPressed: () {
                  Navigator.pushNamed(context, KRouter.searchScreen,
                      arguments:
                          BlocProvider.of<ProductsCubit>(context).products);
                  HapticFeedback.heavyImpact();
                },
                widget: const Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 32,
                ),
              ),
              AppIcon(
                opacity: .15,
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
                widget: Image.asset(
                  AssetsImages.menu,
                  height: 32,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
