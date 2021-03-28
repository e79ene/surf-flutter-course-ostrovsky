import 'package:flutter/material.dart';

class Distance extends ValueNotifier<double> {
  static const minDistance = 100.0;
  static const maxDistance = 20000000.0;

  Distance() : super(minDistance);
}

final distance = Distance();
