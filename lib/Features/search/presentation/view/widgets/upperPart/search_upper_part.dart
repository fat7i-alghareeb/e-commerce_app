import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../../shared/widgets/app_icon.dart';
import '../../../../../../utils/assets.dart';
import '../../../../../../utils/helper_extensions.dart';
import 'search_widget.dart';

class SearchUpperPart extends StatefulWidget {
  const SearchUpperPart({
    super.key,
  });

  @override
  State<SearchUpperPart> createState() => _SearchUpperPartState();
}

class _SearchUpperPartState extends State<SearchUpperPart> {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Row(
        children: [
          AppIcon(
            widget: SvgPicture.asset(
              AssetsImages.backArrow,
              height: 20,
              colorFilter: ColorFilter.mode(
                context.onPrimaryColor(),
                BlendMode.srcIn,
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
              HapticFeedback.heavyImpact();
            },
          ),
          const SizedBox(
            width: 10,
          ),
          const Expanded(
            child: SearchWidget(),
          ),
        ],
      ),
    );
  }
}
