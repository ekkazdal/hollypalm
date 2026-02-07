import 'package:flutter/material.dart';

abstract class HollyColor {
  // BRAND COLORS
  static const Color primary = Color.fromRGBO(12, 18, 38, 1); // Deep Navy
  static const Color secondary = Color.fromRGBO(42, 196, 183, 1); // Mint Teal
  static const Color secondaryLight = Color.fromRGBO(210, 245, 241, 1);

  // NEUTRAL
  static const Color black = Color.fromRGBO(20, 20, 24, 1);
  static const Color gray = Color.fromRGBO(128, 128, 138, 1);
  static const Color white = Color.fromRGBO(255, 255, 255, 1);

  static const Color background = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFF8F9FC);

  static const Color textPrimary = Color(0xFF202020);
  static const Color textSecondary = Color(0xFF9594AE);

  static const Color border = Color(0xFFE5E7EB);

  // PRIMARY SCALE (NAVY)
  static const Color primary25 = Color.fromRGBO(246, 247, 250, 1);
  static const Color primary50 = Color.fromRGBO(233, 235, 240, 1);
  static const Color primary100 = Color.fromRGBO(200, 205, 218, 1);
  static const Color primary200 = Color.fromRGBO(166, 175, 196, 1);
  static const Color primary300 = Color.fromRGBO(132, 145, 174, 1);
  static const Color primary400 = Color.fromRGBO(98, 115, 152, 1);
  static const Color primary500 = Color.fromRGBO(64, 85, 130, 1);
  static const Color primary600 = Color.fromRGBO(45, 63, 105, 1);
  static const Color primary700 = Color.fromRGBO(32, 46, 84, 1);
  static const Color primary800 = Color.fromRGBO(20, 30, 58, 1);
  static const Color primary900 = Color.fromRGBO(12, 18, 38, 1);

  // SECONDARY SCALE (MINT)
  static const Color secondary25 = Color.fromRGBO(244, 253, 252, 1);
  static const Color secondary50 = Color.fromRGBO(230, 249, 247, 1);
  static const Color secondary100 = Color.fromRGBO(194, 240, 235, 1);
  static const Color secondary200 = Color.fromRGBO(156, 230, 223, 1);
  static const Color secondary300 = Color.fromRGBO(118, 221, 210, 1);
  static const Color secondary400 = Color.fromRGBO(80, 209, 197, 1);
  static const Color secondary500 = Color.fromRGBO(42, 196, 183, 1);
  static const Color secondary600 = Color.fromRGBO(32, 168, 158, 1);
  static const Color secondary700 = Color.fromRGBO(24, 138, 131, 1);
  static const Color secondary800 = Color.fromRGBO(18, 109, 104, 1);
  static const Color secondary900 = Color.fromRGBO(12, 82, 79, 1);

  // GRAY SCALE
  static const Color gray25 = Color.fromRGBO(252, 252, 253, 1);
  static const Color gray50 = Color.fromRGBO(249, 250, 251, 1);
  static const Color gray100 = Color.fromRGBO(242, 244, 247, 1);
  static const Color gray200 = Color.fromRGBO(228, 231, 236, 1);
  static const Color gray300 = Color.fromRGBO(208, 213, 221, 1);
  static const Color gray400 = Color.fromRGBO(152, 162, 179, 1);
  static const Color gray500 = Color.fromRGBO(102, 112, 133, 1);
  static const Color gray600 = Color.fromRGBO(71, 84, 103, 1);
  static const Color gray700 = Color.fromRGBO(52, 64, 84, 1);
  static const Color gray800 = Color.fromRGBO(29, 41, 57, 1);
  static const Color gray900 = Color.fromRGBO(16, 24, 40, 1);

  // STATE COLORS
  static const Color success = Color.fromRGBO(18, 183, 106, 1);
  static const Color warning = Color.fromRGBO(247, 144, 9, 1);
  static const Color error = Color.fromRGBO(217, 45, 32, 1);
}
