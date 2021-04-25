import 'package:flutter/material.dart';
import 'package:places/ui/res/themes.dart';

class ThemeInteractor {
  void addListener(VoidCallback onSwitch) => _isDark.addListener(onSwitch);

  final _isDark = ValueNotifier(false);

  bool get isDark => _isDark.value;
  set isDark(bool v) => _isDark.value = v;

  ThemeData get theme => isDark ? Themes.dark : Themes.light;
}

final themeInteractor = ThemeInteractor();
