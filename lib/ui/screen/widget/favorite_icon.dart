import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/data/bloc/favorite_list_bloc.dart';
import 'package:places/data/bloc/place_list_state.dart';
import 'package:places/data/model/place.dart';
import 'package:places/ui/res/my_icons.dart';
import 'package:places/ui/svg_icon.dart';

class FavoriteIcon extends StatelessWidget {
  final Place place;

  const FavoriteIcon(
    this.place, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteListBloc, PlaceListState>(
      builder: (context, state) => SvgIcon(
        state.list.contains(place) ? MyIcons.Heart_Full : MyIcons.Heart,
      ),
    );
  }
}
