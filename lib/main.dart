// @dart=2.9
import 'package:flutter/material.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screen/filters_screen.dart';
import 'package:places/ui/screen/res/settings_screen.dart';
import 'package:places/ui/screen/res/themes.dart';
import 'package:places/ui/screen/sight_details_screen.dart';
import 'package:places/ui/screen/sight_list_screen.dart';
import 'package:places/ui/screen/visiting_screen.dart';

void main() {
  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    isDarkTheme.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final list = SightListScreen(),
        filters = FiltersScreen(),
        details = SightDetailsScreen(mocks[0]),
        settings = SettingsScreen(),
        visiting = VisitingScreen();

    // ignore: unused_local_variable
    final screens = [list, filters, details, settings, visiting];

    // ignore: unused_local_variable
    final screensRow = Row(children: [
      for (final s in [filters, list, details]) Expanded(child: s),
    ]);

    return MaterialApp(
      title: 'Интересные места',
      theme: isDarkTheme.value ? darkTheme : lightTheme,
      home: Row(
        children: [
          Expanded(
            child: settings,
          ),
          Expanded(
            child: filters,
          ),
          Expanded(
            child: list,
          ),
        ],
      ),
    );
  }
}
