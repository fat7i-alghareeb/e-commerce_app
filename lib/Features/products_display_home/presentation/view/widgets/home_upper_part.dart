import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../shared/widgets/app_icon.dart';
import '../../../../../utils/assets.dart';
import '../../../../../utils/router/router_paths.dart';
import '../../manger/products cubit/products_cubit.dart';

class HomeUpperPart extends StatelessWidget {
  const HomeUpperPart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 50,
              width: 50,
              child: CircleAvatar(
                child: Image.asset(
                  AssetsImages.user,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(
              height: 50,
              width: 50,
              child: AppIcon(
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
                widget: Image.asset(
                  AssetsImages.menu,
                  height: 30,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, KRouter.searchScreen,
                arguments: BlocProvider.of<ProductsCubit>(context).products);
            HapticFeedback.heavyImpact();
          },
          child: Container(
            height: 45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              color: Theme.of(context).colorScheme.tertiary,
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Row(
                children: [
                  SvgPicture.asset(AssetsImages.search),
                  const SizedBox(width: 10),
                  const Text(
                    "Search",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}



//  Stack(
//       children: [
//         const SwiperWidget(),
//         Padding(
//           padding: const EdgeInsets.fromLTRB(0, 30, 10, 0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               AppIcon(
//                 onPressed: () {
//                   Navigator.pushNamed(context, KRouter.searchScreen,
//                       arguments:
//                           BlocProvider.of<ProductsCubit>(context).products);
//                   HapticFeedback.heavyImpact();
//                 },
//                 widget: const Icon(
//                   Icons.search,
//                   color: Colors.white,
//                   size: 32,
//                 ),
//               ),
//               AppIcon(
//                 onPressed: () {
//                   Scaffold.of(context).openEndDrawer();
//                 },
//                 widget: Image.asset(
//                   AssetsImages.menu,
//                   height: 32,
//                   color: Colors.white,
//                 ),
//               ),
//             ],
//           ),
//         )
//       ],
//     );