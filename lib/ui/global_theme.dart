import 'dart:ui';

import 'package:flutter/material.dart';

const barHeight = 136.0;
const barStyle = TextStyle(
  color: Colors.black,
  fontSize: 32,
);
final imageStubColor = Colors.lightBlue[900];
const imageStubUrlStyle = TextStyle(color: Colors.grey);
const onImageElementColor = Colors.white;
const sightNameStyle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
);
const sightTypeStyle = TextStyle(
  color: onImageElementColor,
  fontWeight: FontWeight.bold,
);
const sightScreenNameStyle = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.bold,
);
const sightScreenTypeStyle = TextStyle(
  fontWeight: FontWeight.bold,
);
final sightClosedStyle = TextStyle(
  color: Colors.grey[700],
);
const routeButtonBackground = Colors.green;
const routeButtonForeground = Colors.white;
const routeButtonStyle = TextStyle(
  color: routeButtonForeground,
  fontWeight: FontWeight.bold,
);
const disabledButtonForeground = Colors.grey;
const disabledButtonStyle = TextStyle(
  color: disabledButtonForeground,
);
const plannedForStyle = TextStyle(color: Color(0xFF4CAF50));
const goalAchievedStyle = TextStyle(color: Color(0xFF7C7E92));
const closedTillStyle = TextStyle(color: Color(0xFF7C7E92));

class GlobalTheme {
  static ThemeData theme() {
    final base = ThemeData.light();
    return base.copyWith(
      appBarTheme: base.appBarTheme.copyWith(
        backgroundColor: base.scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: true,
        textTheme: base.textTheme.copyWith(
          headline6: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        /* Somehow doesn't work !!!
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 32,
        ),
        */
      ),
    );
  }
}
