import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/global_theme.dart';

class SightCard extends StatelessWidget {
  final Sight _sight;

  SightCard(this._sight);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Stack(children: [
          Container(
            width: double.infinity,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(9)),
              color: imageStubColor,
            ),
            padding: EdgeInsets.all(9),
            child: Text(
              _sight.url,
              style: imageStubUrlStyle,
            ),
          ),
          Positioned(
            top: 16,
            left: 18,
            child: Text(
              _sight.type,
              style: sightTypeStyle,
            ),
          ),
          Positioned(
            top: 5,
            right: 8,
            child: IconButton(
              icon: Icon(Icons.favorite_border),
              onPressed: () {},
              color: onImageElementColor,
            ),
          ),
        ]),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                _sight.name,
                style: sightNameStyle,
              ),
              Text(_sight.details),
            ],
          ),
        ),
      ],
    );
  }
}
