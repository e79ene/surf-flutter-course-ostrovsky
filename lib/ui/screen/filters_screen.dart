import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/data/model/category.dart';
import 'package:places/data/store/place_store.dart';
import 'package:places/ui/res/my_icons.dart';
import 'package:places/ui/res/themes.dart';
import 'package:places/ui/screen/widget/my_app_bar.dart';
import 'package:provider/provider.dart';

class FiltersScreen extends StatelessWidget {
  static double sliderToDistance(double sliderValue) => exp(sliderValue);
  static double distanceToSlider(double distance) => log(distance);
  String km(double radius) => (radius / 1000).toStringAsFixed(2);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final placeStore = context.watch<PlaceStore>();

    return Scaffold(
      appBar: MyAppBar(
        title: '',
        trailing: TextButton(
          child: Text('Очистить'),
          style: TextButton.styleFrom(
            primary: theme.color.green,
          ),
          onPressed: () => placeStore.clearFilter(),
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
            Observer(
              builder: (context) => Wrap(
                alignment: WrapAlignment.spaceEvenly,
                children: [
                  for (final c in Category.filterList)
                    InkWell(
                      onTap: () => placeStore.toggleCategory(c),
                      child: _Category(
                        name: c.name,
                        assetName: c.assetName!,
                        checked: placeStore.categories.contains(c),
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Расстояние'),
                  Observer(
                    builder: (context) => Text(
                      'до ${km(placeStore.radius)} км',
                      style: TextStyle(color: theme.color.secondary2),
                    ),
                  ),
                ],
              ),
            ),
            Observer(
              builder: (context) => Slider(
                value: distanceToSlider(placeStore.radius),
                min: distanceToSlider(placeStore.minRadius),
                max: distanceToSlider(placeStore.maxRadius),
                onChanged: (s) => placeStore.radius = sliderToDistance(s),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Observer(
          builder: (context) => buildShowButton(
              context, placeStore.filtered.value?.length.toString() ?? '???'),
        ),
      ),
    );
  }

  Widget buildShowButton(BuildContext context, String amount) {
    return ElevatedButton(
      child: Text('ПОКАЗАТЬ ($amount)'),
      onPressed: () => Navigator.of(context).pop(),
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
