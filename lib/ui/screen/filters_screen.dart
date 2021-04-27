import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/model/category.dart';
import 'package:places/data/model/place.dart';
import 'package:places/ui/res/my_icons.dart';
import 'package:places/ui/res/themes.dart';
import 'package:places/ui/screen/widget/my_app_bar.dart';
import 'package:relation/relation.dart';

class FiltersScreen extends StatefulWidget {
  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  static String get km => (placeInteractor.radius / 1000).toStringAsFixed(2);
  static double sliderToDistance(double sliderValue) => exp(sliderValue);
  static double distanceToSlider(double distance) => log(distance);

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
          onPressed: () => setState(() => placeInteractor.clearFilter()),
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
                for (final c in Category.filterList)
                  InkWell(
                    onTap: () =>
                        setState(() => placeInteractor.toggleCategory(c)),
                    child: _Category(
                      name: c.name,
                      assetName: c.assetName!,
                      checked: placeInteractor.hasCategory(c),
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
                    'до $km км',
                    style: TextStyle(color: theme.color.secondary2),
                  ),
                ],
              ),
            ),
            Slider(
              value: distanceToSlider(placeInteractor.radius),
              min: distanceToSlider(PlaceInteractor.minRadius),
              max: distanceToSlider(PlaceInteractor.maxRadius),
              onChanged: (s) =>
                  setState(() => placeInteractor.radius = sliderToDistance(s)),
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: EntityStateBuilder(
          streamedState: placeInteractor.filteredPlaces,
          child: (_, List<Place>? places) =>
              buildShowButton('${places!.length}'),
          loadingBuilder: (_, List<Place>? places) =>
              buildShowButton(places != null ? '${places.length}' : '???'),
          errorChild: buildShowButton('???'),
        ),
      ),
    );
  }

  ElevatedButton buildShowButton(String amount) {
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
