import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTitle extends StatelessWidget {
  final String title;
  final double? fontsize;
  final TextAlign? textAlign;
  final int? maxLines;
  final Color? color;
  final FontWeight? fontWeight;
  final TextDecoration? decoration;
  const CustomTitle({
    super.key,
    required this.title,
    this.fontsize,
    this.textAlign,
    this.maxLines,
    this.color,
    this.fontWeight,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: textAlign ?? TextAlign.center,
      maxLines: maxLines ?? 5,
      style: GoogleFonts.poppins(
          decoration: decoration,
          fontSize: fontsize ?? 18,
          color: color ?? Colors.black,
          fontWeight: fontWeight ?? FontWeight.w600),
    );
  }
}

class CustomSubTitle extends StatelessWidget {
  final String title;
  final double? fontsize;
  final TextAlign? textAlign;
  final int? maxLines;
  final Color? color;
  final TextDecoration? decoration;

  const CustomSubTitle({
    super.key,
    required this.title,
    this.fontsize,
    this.textAlign,
    this.maxLines,
    this.color,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: textAlign ?? TextAlign.center,
      maxLines: maxLines ?? 5,
      style: GoogleFonts.poppins(
        decoration: decoration,
        fontSize: fontsize ?? 16,
        color: color ?? Colors.black,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
