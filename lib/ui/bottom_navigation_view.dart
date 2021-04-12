import 'package:flutter/material.dart';
import 'package:places/ui/res/my_icons.dart';
import 'package:places/ui/svg_icon.dart';

class BottomNavigationView extends BottomNavigationBar {
  BottomNavigationView()
      : super(
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: SvgIcon(MyIcons.List),
              label: 'Список интересных мест',
            ),
            BottomNavigationBarItem(
              icon: SvgIcon(MyIcons.Heart),
              label: 'Хочу посетить / Посещенные места',
            ),
            BottomNavigationBarItem(
              icon: SvgIcon(MyIcons.Settings),
              label: 'Настройки',
            ),
          ],
        );
}
