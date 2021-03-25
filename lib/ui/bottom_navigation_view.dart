import 'package:flutter/material.dart';

class BottomNavigationView extends BottomNavigationBar {
  BottomNavigationView()
      : super(
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'Список интересных мест',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border),
              label: 'Хочу посетить / Посещенные места',
            ),
          ],
        );
}
