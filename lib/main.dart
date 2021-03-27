// @dart=2.9
import 'package:flutter/material.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screen/res/themes.dart';
import 'package:places/ui/screen/sight_details_screen.dart';
import 'package:places/ui/screen/sight_list_screen.dart';
import 'package:places/ui/screen/visiting_screen.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final list = SightListScreen(),
        details = SightDetailsScreen(mocks[0]),
        visiting = VisitingScreen();

    // ignore: unused_local_variable
    final screensRow = Row(children: [
      for (final s in [list, visiting, details]) Expanded(child: s),
    ]);

    return MaterialApp(
      title: 'Заголовок',
      theme: lightTheme,
      // home: list,
      //*
      home: Column(
        children: [
          Expanded(
            child: Theme(data: lightTheme, child: screensRow),
          ),
          Expanded(
            child: Theme(data: darkTheme, child: screensRow),
          ),
        ],
      ),
      // */
    );
  }
}
