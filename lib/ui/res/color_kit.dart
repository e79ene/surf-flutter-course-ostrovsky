import 'package:flutter/material.dart';

class _WHITE {
  static const Background = Color(0xFFF5F5F5);
  static const Green = Color(0xFF4CAF50);
  static const InactiveBlack = Color.fromRGBO(124, 126, 146, 0.56);
  static const Main = Color(0xFF252849);
  static const Red = Color(0xFFEF4343);
  static const Secondary2 = Color(0xFF7C7E92);
  static const Secondary = Color(0xFF3B3E5B);
  static const White = Color(0xFFFFFFFF);
  static const Yellow = Color(0xFFFCDD3D);
}

class _BLACK {
  static const Dark = Color(0xFF1A1A20);
  static const Green = Color(0xFF6ADA6F);
  static const InactiveBlack = Color.fromRGBO(124, 126, 146, 0.56);
  static const Main = Color(0xFF21222C);
  static const Red = Color(0xFFCF2A2A);
  static const Secondary2 = Color(0xFF7C7E92);
  static const White = Color(0xFFFFFFFF);
  static const Yellow = Color(0xFFFFE769);
}

class ColorKit {
  const ColorKit({
    required this.background,
    required this.card,
    required this.secondary2,
    required this.secondary,
    required this.foreground,
    required this.title,
    required this.red,
    required this.white,
    required this.green,
    required this.yellow,
    required this.inactiveBlack,
  });

  final Color background,
      card,
      secondary2,
      secondary,
      foreground,
      title,
      red,
      white,
      green,
      yellow,
      inactiveBlack;

  static ColorKit get light => ColorKit(
        background: _WHITE.White,
        card: _WHITE.Background,
        secondary2: _WHITE.Secondary2,
        secondary: _WHITE.Secondary,
        foreground: _WHITE.Secondary,
        title: _WHITE.Main,
        red: _WHITE.Red,
        white: _WHITE.White,
        green: _WHITE.Green,
        yellow: _WHITE.Yellow,
        inactiveBlack: _WHITE.InactiveBlack,
      );

  static ColorKit get dark => ColorKit(
        background: _BLACK.Main,
        card: _BLACK.Dark,
        secondary2: _BLACK.Secondary2,
        secondary: _BLACK.Secondary2,
        foreground: _BLACK.White,
        title: _BLACK.White,
        red: _BLACK.Red,
        white: _BLACK.White,
        green: _BLACK.Green,
        yellow: _BLACK.Yellow,
        inactiveBlack: _BLACK.InactiveBlack,
      );
}
