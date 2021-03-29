import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/domain/category.dart';
import 'package:places/domain/sights_finder.dart';
import 'package:places/ui/my_back_button.dart';

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
                      child: Text(
                        'Категории',
                        style: theme.textTheme.headline5,
                      ),
                    ),
                    Column(
                      children: [
                        for (final categoryRow
                            in _splitList(categories.entries.toList(), 3))
                          Padding(
                            padding: const EdgeInsets.only(bottom: 40),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                for (final e in categoryRow)
                                  _Category(
                                    name: e.key,
                                    assetName: e.value,
                                    checked: true,
                                  ),
                              ],
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
                            style: TextStyle(color: theme.disabledColor),
                          ),
                        ],
                      ),
                    ),
                    Slider(
                      value: distanceToSlider(sightsFinder.distance),
                      min: distanceToSlider(SightsFinder.minDistance),
                      max: distanceToSlider(SightsFinder.maxDistance),
                      onChanged: (s) =>
                          sightsFinder.distance = sliderToDistance(s),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: ElevatedButton(
                child: Text('ПОКАЗАТЬ (${sightsFinder.result.length})'),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<List<E>> _splitList<E>(List<E> list, int count) =>
    [for (int i = 0; i < list.length; i += count) list.sublist(i, i + count)];

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
    final assetMode = (theme.brightness == Brightness.dark) ? 'Black' : 'White';
    final assetDir = 'res/figma/Icons/Catalog/$assetMode';

    return SizedBox(
      width: 96,
      height: 92,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Stack(
            children: [
              SvgPicture.asset('$assetDir/$assetName.svg'),
              if (checked)
                Positioned(
                  bottom: -4,
                  right: -4,
                  child: SvgPicture.asset('$assetDir/tick_choice.svg'),
                ),
            ],
          ),
          Text(
            name,
            style: theme.textTheme.headline4,
          ),
        ],
      ),
    );
  }
}
