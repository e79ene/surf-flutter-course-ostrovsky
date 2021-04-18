import 'package:flutter/material.dart';
import 'package:places/ui/res/my_icons.dart';
import 'package:places/ui/screen/settings_screen.dart';
import 'package:places/ui/screen/sight_list_screen.dart';
import 'package:places/ui/screen/visiting_screen.dart';
import 'package:places/ui/svg_icon.dart';

class BottomNavigationView extends StatelessWidget {
  final items = [
    _Item(
      'Список интересных мест',
      MyIcons.List,
      (context) => SightListScreen(),
    ),
    _Item(
      'Хочу посетить / Посещенные места',
      MyIcons.Heart,
      (context) => VisitingScreen(),
    ),
    _Item(
      'Настройки',
      MyIcons.Settings,
      (context) => SettingsScreen(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: [
        for (final item in items)
          BottomNavigationBarItem(
            icon: SvgIcon(item.assetName),
            label: item.label,
          ),
      ],
      onTap: (index) => Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: items[index].builder),
        (_) => false,
      ),
    );
  }
}

class _Item {
  _Item(this.label, this.assetName, this.builder);

  final String label;
  final String assetName;
  final WidgetBuilder builder;
}
