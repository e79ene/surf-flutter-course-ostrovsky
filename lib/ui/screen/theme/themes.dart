import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:places/ui/screen/theme/color_kit.dart';
import 'package:places/ui/screen/theme/text_kit.dart';

class Themes {
  static ThemeData get light => MyTheme.fromKits(
      Brightness.light, ColorKit.light, TextKit.fromColors(ColorKit.light));

  static ThemeData get dark => MyTheme.fromKits(
      Brightness.dark, ColorKit.dark, TextKit.fromColors(ColorKit.dark));
}

extension MyTheme on ThemeData {
  bool get isDark => brightness == Brightness.dark;

  ColorKit get color => isDark ? ColorKit.dark : ColorKit.light;

  TextKit get text => TextKit.fromColors(color);

  ButtonStyle get textButtonGreen => TextButton.styleFrom(primary: color.green);

  static ThemeData fromKits(
      Brightness brightness, ColorKit color, TextKit text) {
    return ThemeData(
      brightness: brightness,
      scaffoldBackgroundColor: color.background,
      canvasColor: color.background,
      errorColor: color.error,
      textSelectionTheme: TextSelectionThemeData(cursorColor: color.foreground),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          primary: color.green,
          onPrimary: color.white,
          minimumSize: Size.fromHeight(48),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          textStyle: text.button,
        ).copyWith(
          elevation: MaterialStateProperty.all(0),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.resolveWith((states) =>
              states.contains(MaterialState.disabled)
                  ? color.inactiveBlack
                  : color.foreground),
        ),
      ),
      appBarTheme: AppBarTheme(
        backwardsCompatibility: false,
        backgroundColor: color.background,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: text.subTitle,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: color.title,
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: color.green,
        inactiveTrackColor: color.secondary2,
        trackHeight: 1,
        thumbColor: color.white,
        overlayColor: color.green.withAlpha(0x1f),
      ),
      inputDecorationTheme: InputDecorationTheme(
        isDense: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: color.green),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: color.green.withOpacity(0.5)),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }
}

class ThemeSwitcher {
  void addListener(VoidCallback onSwitch) => _isDark.addListener(onSwitch);

  final _isDark = ValueNotifier(false);

  bool get isDark => _isDark.value;
  set isDark(bool v) => _isDark.value = v;

  ThemeData get theme => isDark ? Themes.dark : Themes.light;
}

final themeSwitcher = ThemeSwitcher();
