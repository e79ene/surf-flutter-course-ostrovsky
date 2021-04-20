import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/domain/category.dart';
import 'package:places/domain/sights_finder.dart';
import 'package:places/ui/res/my_icons.dart';
import 'package:places/ui/res/themes.dart';
import 'package:places/ui/screen/widget/my_app_bar.dart';

class FiltersScreen extends StatefulWidget {
  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  static String get km => (sightsFinder.distance / 1000).toStringAsFixed(2);
  static double sliderToDistance(double sliderValue) => exp(sliderValue);
  static double distanceToSlider(double distance) => log(distance);

  @override
  void initState() {
    sightsFinder.paramatersNotifier.addListener(() => setState(() {}));
    sightsFinder.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: MyAppBar(
        title: '',
        trailing: TextButton(
          child: Text('Очистить'),
          style: TextButton.styleFrom(
            primary: theme.color.green,
          ),
          onPressed: () => throw UnimplementedError(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Text(
                'Категории',
                style: theme.text.superSmallInactive,
              ),
            ),
            Wrap(
              alignment: WrapAlignment.spaceEvenly,
              children: [
                for (final e in categories.entries.toList())
                  InkWell(
                    onTap: () => sightsFinder.toggleCategory(e.key),
                    child: _Category(
                      name: e.key,
                      assetName: e.value,
                      checked: sightsFinder.hasCategory(e.key),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Расстояние'),
                  Text(
                    'от XXX до $km км',
                    style: TextStyle(color: theme.color.secondary2),
                  ),
                ],
              ),
            ),
            Slider(
              value: distanceToSlider(sightsFinder.distance),
              min: distanceToSlider(SightsFinder.minDistance),
              max: distanceToSlider(SightsFinder.maxDistance),
              onChanged: (s) => sightsFinder.distance = sliderToDistance(s),
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: ElevatedButton(
          child: Text('ПОКАЗАТЬ (${sightsFinder.filtered.length})'),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }
}

class _Category extends StatelessWidget {
  final String name;
  final String assetName;
  final bool checked;

  const _Category({
    Key? key,
    required this.name,
    required this.assetName,
    required this.checked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: 96,
      height: 92,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Stack(
            children: [
              SvgPicture.asset(
                MyIcons.forCategory(theme.brightness, assetName),
              ),
              if (checked)
                Positioned(
                  bottom: -4,
                  right: -4,
                  child: SvgPicture.asset(
                    MyIcons.forCategory(theme.brightness, 'tick_choice'),
                  ),
                ),
            ],
          ),
          Text(name, style: theme.text.superSmall),
        ],
      ),
    );
  }
}
