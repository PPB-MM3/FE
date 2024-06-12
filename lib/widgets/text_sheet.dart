import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:telfood/helper/app_colors.dart';

class TextSheet extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final Color? color;
  final double? size;
  final FontWeight? fontWeight;
  final TextDecoration? decoration;
  final TextOverflow? overflow;
  final int? maxLines;

  const TextSheet({
    super.key,
    required this.text,
    this.textAlign,
    this.color,
    this.size,
    this.fontWeight,
    this.decoration,
    this.overflow,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: GoogleFonts.sen(
        color: color ?? AppColors.text,
        fontSize: size,
        fontWeight: fontWeight ?? FontWeight.w400,
        decoration: decoration,
        decorationColor: color ?? AppColors.text,
      ),
    );
  }
}
