import 'package:flutter/material.dart';

class Clipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width * -0.0028000, size.height * 0.5488000);
    path.quadraticBezierTo(size.width * 0.1018000, size.height * 0.4364000,
        size.width * 0.2700000, size.height * 0.4416000);
    path.cubicTo(
        size.width * 0.5325000,
        size.height * 0.4599000,
        size.width * 0.7247000,
        size.height * 0.6709000,
        size.width,
        size.height * 0.5980000);
    path.quadraticBezierTo(size.width * 1.0005000, size.height * 0.4480000,
        size.width * 1.0020000, size.height * -0.0020000);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
