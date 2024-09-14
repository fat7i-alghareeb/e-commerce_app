import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:store_app/utils/helper_extensions.dart';

void signInLoadingIndicator(
    {required BuildContext context, required bool isLoading}) {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor:
          isLoading ? Colors.black : context.primaryColor(),
    ),
  );
  isLoading
      ? showDialog(
          context: context,
          builder: (context) => Center(
            child: CircularProgressIndicator(
              color: context.accentColor(),
            ),
          ),
        )
      : Navigator.pop(context);
}
