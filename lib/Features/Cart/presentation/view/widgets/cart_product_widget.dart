import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../shared/widgets/app_image.dart';
import '../../../../../utils/router/router_paths.dart';
import 'package:flutter/material.dart';
import '../../../../../utils/assets.dart';
import '../../../../../shared/models/product.dart';

class CartProductWidget extends StatelessWidget {
  const CartProductWidget({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          KRouter.detailsScreen,
          arguments: {
            "fromHome": false,
            "product": product,
          },
        );
      },
      child: Card(
        color: Theme.of(context).colorScheme.tertiary,
        shadowColor: Theme.of(context).colorScheme.secondary.withOpacity(.05),
        elevation: 1,
        margin: EdgeInsets.zero,
        child: SizedBox(
          height: 120,
          child: Row(
            children: [
              AppImage(
                image: product.thumbnail,
                id: product.id,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 8, right: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        //softWrap: false,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Text(
                        '\$${product.price} USD',
                        style: const TextStyle(
                            //fontSize: 15,
                            ),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: SvgPicture.asset(
                  AssetsImages.backArrow,
                  height: 25,
                  colorFilter: const ColorFilter.mode(
                    Colors.grey,
                    BlendMode.srcIn,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
