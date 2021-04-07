import 'package:flutter/material.dart';
import 'package:places/ui/screen/theme/color_kit.dart';

extension MyTextStyle on TextStyle {
  TextStyle withColor(Color color) => copyWith(color: color);
}

class TextKit {
  final TextStyle largeTitle,
      title,
      subTitle,
      text,
      smallBold,
      small,
      button,
      superSmall,
      superSmallInactive;

  TextKit.fromColors(ColorKit color)
      : largeTitle = TextStyle(
          fontSize: 32,
          color: color.title,
          fontWeight: FontWeight.bold,
          height: 36 / 32,
        ),
        title = TextStyle(
          fontSize: 24,
          color: color.foreground,
          fontWeight: FontWeight.bold,
          height: 28.8 / 24,
        ),
        subTitle = TextStyle(
          fontSize: 18,
          color: color.title,
          fontWeight: FontWeight.w500,
          height: 24 / 18,
        ),
        text = TextStyle(
          fontSize: 16,
          color: color.foreground,
          fontWeight: FontWeight.w500,
          height: 20 / 16,
        ),
        smallBold = TextStyle(
          fontSize: 14,
          color: color.white,
          fontWeight: FontWeight.bold,
          height: 18 / 14,
        ),
        small = TextStyle(
          fontSize: 14,
          color: color.error,
          fontWeight: FontWeight.normal,
          height: 18 / 14,
        ),
        button = TextStyle(
          fontSize: 14,
          color: color.white,
          fontWeight: FontWeight.bold,
          height: 18 / 14,
          letterSpacing: 14 * 0.03,
        ),
        superSmall = TextStyle(
          fontSize: 12,
          color: color.foreground,
          fontWeight: FontWeight.normal,
          height: 16 / 12,
        ),
        superSmallInactive = TextStyle(
          fontSize: 12,
          color: color.inactiveBlack,
          fontWeight: FontWeight.normal,
          height: 16 / 12,
        );
}
