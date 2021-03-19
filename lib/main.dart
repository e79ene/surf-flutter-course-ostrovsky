// @dart=2.9
import 'package:flutter/material.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/global_theme.dart';
import 'package:places/ui/screen/sight_details_screen.dart';
import 'package:places/ui/screen/sight_list_screen.dart';
import 'package:places/ui/screen/visiting_screen.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screens = {
      'list': SightListScreen(),
      'details': SightDetailsScreen(mocks[0]),
      'visiting': VisitingScreen(),
    };

    return MaterialApp(
      title: 'Заголовок',
      theme: GlobalTheme.theme(),
      home: screens['visiting'],
    );
  }
}
