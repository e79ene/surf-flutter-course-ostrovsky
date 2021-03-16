import 'package:flutter/material.dart';

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

class GlobalTheme {
  static ThemeData theme() {
    final base = ThemeData.light();
    return base.copyWith(
      appBarTheme: base.appBarTheme.copyWith(
        backgroundColor: base.scaffoldBackgroundColor,
        elevation: 0,
        textTheme: base.textTheme.copyWith(
          headline6: TextStyle(
            color: Colors.black,
            fontSize: 32,
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
