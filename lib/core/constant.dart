import 'dart:ui';

import 'package:flutter/material.dart';

/// colors
const prColor = Color(0xFFF67952);
const Color bgColor = Color(0xFFFBFBFD);
const Color appbarClr = Color(0xFFb7b7a4);
const Color blueClr = Color(0xFF4e5ae8);
const Color blClr = Color(0xFF48cae4);
const Color yellowClr = Color(0xFFEEA638);
const Color starClr = Color(0xFFFFDF00);
const Color pinkClr = Color(0xFFff4667);
const Color pnkClr = Color(0xFFff4667);
const Color greenClr = Color(0xFF99C24D);

/// color for test
const Color primaryColor = Color(0xFF388E3C);
const Color secondaryColor = Color(0xFFA5D6A7);
const Color backgroundColor = Color(0xFFF1F8E9);
const Color textColor = Color(0xFF1B1B1B);
const Color text2Color = Color(0xFFF1F8E9);
const Color text3Color = Color(0xFFFFFFFF);

/// padding and borderRadius
const double defaultPadding = 16.0;
const double defaultBorderRadius = 12.0;

class AppColors {
  static const welcomeScreenBackground = Color(0xFFFF4B3A);
  static const primaryColor = Color(0xFFFA4A0C);
  static var secondaryColor = Colors.white;
  static const buttonTextColorPrimary = Color(0xFFFF460A);
  static const buttonTextColorSecondary = Color(0xFFFFFFFF);
  static const backgroundScreens = Color(0xFFF2F2F2);
  static const textFieldInside = Color(0xFFEFEEEE);
  static const statusBarColor = Color(0xFFF2F2F2);
  static const systemNavBarColor = Color(0xFFF2F2F2);

  static final avatorsGradient = [
    AppColors.welcomeScreenBackground.withOpacity(0.01),
    AppColors.welcomeScreenBackground.withOpacity(0.5),
    AppColors.welcomeScreenBackground,
  ];
}
