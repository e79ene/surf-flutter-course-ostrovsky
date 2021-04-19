import 'package:flutter/material.dart';
import 'package:places/ui/res/my_icons.dart';
import 'package:places/ui/screen/settings_screen.dart';
import 'package:places/ui/screen/sight_list_screen.dart';
import 'package:places/ui/screen/visiting_screen.dart';
import 'package:places/ui/svg_icon.dart';

class BottomNavigationView extends StatelessWidget {
  static final itemList = _Item(
    'Список интересных мест',
    MyIcons.List,
    MyIcons.List_Full,
    (context) => SightListScreen(),
  );

  static final itemVisiting = _Item(
    'Хочу посетить / Посещенные места',
    MyIcons.Heart,
    MyIcons.Heart_Full,
    (context) => VisitingScreen(),
  );

  static final itemSettings = _Item(
    'Настройки',
    MyIcons.Settings,
    MyIcons.Settings_fill,
    (context) => SettingsScreen(),
  );

  static final items = [
    itemList,
    itemVisiting,
    itemSettings,
  ];

  final _Item current;

  const BottomNavigationView._(this.current, {Key? key}) : super(key: key);

  factory BottomNavigationView.list() => BottomNavigationView._(itemList);

  factory BottomNavigationView.visiting() =>
      BottomNavigationView._(itemVisiting);

  factory BottomNavigationView.settings() =>
      BottomNavigationView._(itemSettings);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: [
        for (final item in items)
          BottomNavigationBarItem(
            icon: SvgIcon(
              item == current ? item.selectedAssetName : item.assetName,
            ),
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
  const _Item(this.label, this.assetName, this.selectedAssetName, this.builder);

  final String label;
  final String assetName;
  final String selectedAssetName;
  final WidgetBuilder builder;
}
