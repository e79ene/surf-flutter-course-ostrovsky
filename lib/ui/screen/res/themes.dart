import 'dart:ui';
import 'package:flutter/material.dart';

const _lBackgroundColor = Color(0xFFF5F5F5);
const _lGreenColor = Color(0xFF4CAF50);
const _lInactiveBlackColor = Color.fromRGBO(124, 126, 146, 0.56);
const _lMainColor = Color(0xFF252849);
const _lRedColor = Color(0xFFEF4343);
const _lSecondary2Color = Color(0xFF7C7E92);
const _lSecondaryColor = Color(0xFF3B3E5B);
const _lWhiteColor = Color(0xFFFFFFFF);
const _lYellowColor = Color(0xFFFCDD3D);

const _dDarkColor = Color(0xFF1A1A20);
const _dGreenColor = Color(0xFF6ADA6F);
const _dInactiveBlackColor = Color.fromRGBO(124, 126, 146, 0.56);
const _dMainColor = Color(0xFF21222C);
const _dRedColor = Color(0xFFCF2A2A);
const _dSecondary2Color = Color(0xFF7C7E92);
const _dSecondaryColor = Color(0xFF3B3E5B);
const _dWhiteColor = Color(0xFFFFFFFF);
const _dYellowColor = Color(0xFFFFE769);

final lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: _lGreenColor,
  primaryColorLight: _lYellowColor,
  canvasColor: _lWhiteColor,
  scaffoldBackgroundColor: _lWhiteColor,
  cardColor: _lBackgroundColor,
  disabledColor: _lSecondary2Color,
  errorColor: _lRedColor,
  accentColor: _lGreenColor,
  accentTextTheme: TextTheme(
    button: TextStyle(
      inherit: false,
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: _lGreenColor,
    ),
    headline6: TextStyle(
      inherit: false,
      fontWeight: FontWeight.bold,
      color: _lWhiteColor,
    ),
  ),
  accentIconTheme: IconThemeData(
    color: _lWhiteColor,
  ),
  textTheme: TextTheme(
    // SightDetailsScreen/_sight.type
    headline1: TextStyle(
      inherit: false,
      fontWeight: FontWeight.bold,
      color: _lSecondaryColor,
    ),
    // SightDetailsScreen/_sight.name
    headline2: TextStyle(
      inherit: false,
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: _lSecondaryColor,
    ),
    headline3: TextStyle(
      inherit: false,
      fontSize: 16,
      color: _lMainColor,
    ),
    headline4: TextStyle(
      inherit: false,
      fontSize: 12,
      color: _lSecondaryColor,
    ),
    headline5: TextStyle(
      inherit: false,
      fontSize: 12,
      color: _lInactiveBlackColor,
    ),
    headline6: TextStyle(
      inherit: false,
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: _lSecondaryColor,
    ),
    bodyText1: TextStyle(
      inherit: false,
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: _lSecondary2Color,
    ),
    bodyText2: TextStyle(
      inherit: false,
      fontSize: 16,
      color: _lSecondary2Color,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: _lGreenColor,
      onPrimary: _lWhiteColor,
      minimumSize: Size(0, 48),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      textStyle: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      primary: _lSecondaryColor,
      onSurface: _lInactiveBlackColor,
    ),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: _lWhiteColor,
    elevation: 0,
    centerTitle: true,
    textTheme: TextTheme(
      headline6: TextStyle(
        color: _lMainColor,
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    showSelectedLabels: false,
    showUnselectedLabels: false,
    selectedItemColor: _lMainColor,
  ),
  tabBarTheme: TabBarTheme(
    labelColor: _lSecondaryColor,
    labelStyle: TextStyle(
      color: _lWhiteColor,
    ),
    unselectedLabelColor: _lBackgroundColor,
    unselectedLabelStyle: TextStyle(
      color: _lInactiveBlackColor,
    ),
  ),
  sliderTheme: SliderThemeData(
    activeTrackColor: _lGreenColor,
    inactiveTrackColor: _lSecondary2Color,
    trackHeight: 1,
    thumbColor: _lWhiteColor,
    overlayColor: _lGreenColor.withAlpha(0x1f),
  ),
  inputDecorationTheme: InputDecorationTheme(
    isDense: true,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: new BorderSide(color: _lGreenColor.withOpacity(0.5)),
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    foregroundColor: _lWhiteColor,
  ),
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: _dGreenColor,
  primaryColorLight: _dYellowColor,
  scaffoldBackgroundColor: _dMainColor,
  canvasColor: _dMainColor,
  cardColor: _dDarkColor,
  disabledColor: _dSecondary2Color,
  errorColor: _dRedColor,
  accentColor: _dGreenColor,
  accentTextTheme: TextTheme(
    button: TextStyle(
      inherit: false,
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: _dGreenColor,
    ),
    headline6: TextStyle(
      inherit: false,
      fontWeight: FontWeight.bold,
      color: _dWhiteColor,
    ),
  ),
  accentIconTheme: IconThemeData(
    color: _dWhiteColor,
  ),
  textTheme: TextTheme(
    // SightDetailsScreen/_sight.type
    headline1: TextStyle(
      inherit: false,
      fontWeight: FontWeight.bold,
      color: _dSecondary2Color,
    ),
    // SightDetailsScreen/_sight.name
    headline2: TextStyle(
      inherit: false,
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: _dWhiteColor,
    ),
    headline3: TextStyle(
      inherit: false,
      fontSize: 16,
      color: _dWhiteColor,
    ),
    headline4: TextStyle(
      inherit: false,
      fontSize: 12,
      color: _dWhiteColor,
    ),
    headline5: TextStyle(
      inherit: false,
      fontSize: 12,
      color: _dInactiveBlackColor,
    ),
    headline6: TextStyle(
      inherit: false,
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: _dWhiteColor,
    ),
    bodyText1: TextStyle(
      inherit: false,
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: _dSecondary2Color,
    ),
    bodyText2: TextStyle(
      inherit: false,
      fontSize: 16,
      color: _dSecondary2Color,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: _dGreenColor,
      onPrimary: _dWhiteColor,
      minimumSize: Size.fromHeight(48),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      textStyle: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      primary: _dWhiteColor,
      onSurface: _dInactiveBlackColor,
    ),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: _dMainColor,
    elevation: 0,
    centerTitle: true,
    textTheme: TextTheme(
      headline6: TextStyle(
        color: _dWhiteColor,
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    showSelectedLabels: false,
    showUnselectedLabels: false,
    selectedItemColor: _dWhiteColor,
  ),
  tabBarTheme: TabBarTheme(
    labelColor: _dWhiteColor,
    labelStyle: TextStyle(
      color: _dSecondaryColor,
    ),
    unselectedLabelColor: _dDarkColor,
    unselectedLabelStyle: TextStyle(
      color: _dSecondary2Color,
    ),
  ),
  sliderTheme: SliderThemeData(
    activeTrackColor: _dGreenColor,
    inactiveTrackColor: _dSecondary2Color,
    trackHeight: 1,
    thumbColor: _dWhiteColor,
    overlayColor: _dGreenColor.withAlpha(0x1f),
  ),
  inputDecorationTheme: InputDecorationTheme(
    isDense: true,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: new BorderSide(color: _dGreenColor.withOpacity(0.5)),
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    foregroundColor: _dWhiteColor,
  ),
);

final isDarkTheme = ValueNotifier(false);
