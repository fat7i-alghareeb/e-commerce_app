import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../../utils/helper_extensions.dart';

class NavigatorIcon extends StatelessWidget {
  final VoidCallback setChange;
  final bool changing;
  final String icon;
  const NavigatorIcon({
    super.key,
    required this.setChange,
    required this.changing,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: setChange,
        child: Container(
          color: Colors.transparent,
          padding:
              changing ? const EdgeInsets.only(bottom: 8) : EdgeInsets.zero,
          child: Center(
              child: SvgPicture.asset(
            icon,
            colorFilter: ColorFilter.mode(
              changing
                  ? context.accentColor()
                  : context.accentColor().withOpacity(0.12),
              BlendMode.srcIn,
            ),
            height: changing ? 35 : 28,
          )

              //  Icon(
              //   icon,
              //   color: changing
              //       ? context.accentColor()
              //       : context.accentColor().withOpacity(0.1),
              //   size: changing ? 40 : 30,
              // ),
              ),
        ),
      ),
    );
  }
}
