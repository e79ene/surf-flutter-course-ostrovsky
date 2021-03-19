// @dart=2.9
import 'package:flutter/material.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screen/sight_details_screen.dart';
import 'package:places/ui/screen/sight_list_screen.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Заголовок',
      home: (1 > 0) ? SightDetailsScreen(mocks[0]) : SightListScreen(),
    );
  }
}
