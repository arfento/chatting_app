import 'package:flutter/material.dart';

class AppFont {
  static TextStyle get h1 => const TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w700,
      );

  static TextStyle get headerBlack => const TextStyle(
    fontSize: 19,
    fontWeight: FontWeight.w700,
  );

  static TextStyle get headerWhite => const TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w700,
  );

  static TextStyle get subtitle => const TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
  );

  static TextStyle get input => const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w400,
      );

  static TextStyle get label => const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w500,
      );
}
