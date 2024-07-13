import 'package:flutter/material.dart';
import '../../../../../utils/assets.dart';
import 'show_bottom_sheet_button.dart';

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({
    super.key,
    required this.userName,
    required this.gmail,
  });
  final String userName;
  final String gmail;

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image.asset(
          AssetsImages.user,
          height: 85,
          width: 85,
        ),
        const SizedBox(
          height: 40,
        ),
        Card(
          margin: EdgeInsets.zero,
          color: Theme.of(context).colorScheme.tertiary,
          elevation: 10,
          shadowColor: Theme.of(context).colorScheme.secondary.withOpacity(.05),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      gmail,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 18, color: Colors.grey,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                ShowBottomSheetButton(
                  userName: userName,
                  gmail: gmail,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
