import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import '../../../../../utils/assets.dart';

class SwiperWidget extends StatelessWidget {
  const SwiperWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.47,
      child: Swiper(
        viewportFraction: 1,
        //scale: 0.9,
        itemCount: 5,
        duration: 800,
        autoplayDelay: 3000,
        autoplay: true,
        itemBuilder: (context, index) {
          return ImageSliderWidget(
            index: index,
          );
        },
      ),
    );
  }
}

class ImageSliderWidget extends StatelessWidget {
  final int index;
  const ImageSliderWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.45,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            child: Image.asset(
              AssetsImages.thumbs[index],
              fit: BoxFit.cover,
              //width: double.infinity,
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.center,
              colors: [
                Colors.black.withOpacity(0.6),
                Colors.transparent,
              ],
            ),
          ),
        )
      ],
    );
  }
}
