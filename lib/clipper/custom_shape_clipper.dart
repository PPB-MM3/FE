import 'package:flutter/material.dart';

class CustomShapeClipper extends CustomClipper<Path> {
  final double cornerRadius;
  final double? topInsets;

  CustomShapeClipper({super.reclip, required this.cornerRadius, this.topInsets});

  @override
  Path getClip(Size size) {
    final Path path = Path();

    double topInset = topInsets ?? size.width * 0.1;
    print(topInset);

    path.moveTo(topInset + cornerRadius, 0);

    path.lineTo(size.width - topInset - cornerRadius, 0);
    path.quadraticBezierTo(size.width - topInset, 0, size.width - topInset, cornerRadius);

    // bawah kanan
    path.lineTo(size.width, size.height - cornerRadius);
    path.quadraticBezierTo(size.width, size.height, size.width - topInset - cornerRadius, size.height);

    // bawah kiri
    path.lineTo(cornerRadius, size.height);
    path.quadraticBezierTo(0, size.height, 0, size.height - cornerRadius);

    path.lineTo(topInset, cornerRadius);
    path.quadraticBezierTo(topInset, 0, topInset + cornerRadius, 0);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomShapeClipper oldClipper) {
    return false;
  }
}