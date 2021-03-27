import 'package:flutter/material.dart';
import 'package:places/ui/svg_icon.dart';

class BottomNavigationView extends BottomNavigationBar {
  BottomNavigationView()
      : super(
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: SvgIcon('res/figma/Icons/Icon/List.svg'),
              label: 'Список интересных мест',
            ),
            BottomNavigationBarItem(
              icon: SvgIcon('res/figma/Icons/Icon/Heart.svg'),
              label: 'Хочу посетить / Посещенные места',
            ),
          ],
        );
}
