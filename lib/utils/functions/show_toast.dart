import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast({
  required String message,
  required Color? color,
}) {
  Fluttertoast.showToast(
    msg: message,
    backgroundColor: color,
    timeInSecForIosWeb: 2,
    textColor: Colors.white,
    gravity: ToastGravity.BOTTOM,
    toastLength: Toast.LENGTH_SHORT,
  );
}
