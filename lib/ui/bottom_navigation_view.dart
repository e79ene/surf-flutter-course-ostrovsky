import 'package:flutter/material.dart';

class BottomNavigationView extends BottomNavigationBar {
  BottomNavigationView()
      : super(items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Список интересных мест',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_road),
            label: 'Хочу посетить / Посещенные места',
          ),
        ]);
}
