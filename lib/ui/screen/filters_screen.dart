import 'dart:math';

import 'package:flutter/material.dart';
import 'package:places/domain/distance.dart';
import 'package:places/ui/my_back_button.dart';

class FiltersScreen extends StatefulWidget {
  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  static String get km => (distance.value / 1000).toStringAsFixed(2);
  static double sliderToDistance(double sliderValue) => exp(sliderValue);
  static double distanceToSlider(double distance) => log(distance);

  @override
  void initState() {
    distance.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyBackButton(),
                  TextButton(
                    child: Text('Очистить'),
                    style: TextButton.styleFrom(
                      primary: theme.accentColor,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Расстояние'),
                          Text(
                            'от XXX до $km км',
                            style: TextStyle(color: theme.disabledColor),
                          ),
                        ],
                      ),
                    ),
                    Slider(
                      value: distanceToSlider(distance.value),
                      min: distanceToSlider(Distance.minDistance),
                      max: distanceToSlider(Distance.maxDistance),
                      onChanged: (s) => distance.value = sliderToDistance(s),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: ElevatedButton(
                child: Text('ПОКАЗАТЬ (XXX)'),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
