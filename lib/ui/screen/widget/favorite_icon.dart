import 'package:flutter/material.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/model/place.dart';
import 'package:places/ui/res/my_icons.dart';
import 'package:places/ui/svg_icon.dart';
import 'package:relation/relation.dart';

class FavoriteIcon extends StatelessWidget {
  final Place place;

  const FavoriteIcon(
    this.place, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamedStateBuilder(
      streamedState: placeInteractor.favorite,
      builder: (_, List<Place>? places) => SvgIcon(
        places!.contains(place) ? MyIcons.Heart_Full : MyIcons.Heart,
      ),
    );
  }
}
