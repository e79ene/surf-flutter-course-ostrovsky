import 'package:flutter/material.dart';
import 'package:places/domain/sight_repo.dart';
import 'package:places/ui/screen/add_sight_screen.dart';
import 'package:places/ui/screen/filters_screen.dart';
import 'package:places/ui/screen/settings_screen.dart';
import 'package:places/ui/screen/sight_search_screen.dart';
import 'package:places/ui/res/themes.dart';
import 'package:places/ui/screen/sight_details_screen.dart';
import 'package:places/ui/screen/sight_list_screen.dart';
import 'package:places/ui/screen/visiting_screen.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    themeSwitcher.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Интересные места',
      theme: themeSwitcher.theme,
      home: col([
        row([details]),
      ]),
    );
  }

  static Widget dark(child) => Theme(data: Themes.dark, child: child);
  static Widget row(Iterable<Widget> children) =>
      Row(children: [for (final c in children) Expanded(child: c)]);
  static Widget col(Iterable<Widget> children) =>
      Column(children: [for (final c in children) Expanded(child: c)]);

  final list = SightListScreen(),
      search = SightSearchScreen(),
      filters = FiltersScreen(),
      details = SightDetailsScreen(sightRepo.all.first),
      settings = SettingsScreen(),
      add = AddSightScreen(),
      visiting = VisitingScreen();

  // Эти переменные используются для отладки тем и верстки.
  // А когда не используются, то пусть линтер не ругается.
  // ignore: unused_local_variable
  final dontWarn = [dark, row, col];
}
