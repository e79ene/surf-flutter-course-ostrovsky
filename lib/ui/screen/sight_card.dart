import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';

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
              color: Colors.lightBlue[900],
            ),
            padding: EdgeInsets.all(9),
            child: Text(
              _sight.url,
              style: TextStyle(color: Colors.grey),
            ),
          ),
          Positioned(
            top: 16,
            left: 18,
            child: Text(
              _sight.type,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            top: 5,
            right: 8,
            child: IconButton(
              icon: Icon(Icons.favorite_border),
              onPressed: () {},
              color: Colors.white,
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
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(_sight.details),
            ],
          ),
        ),
      ],
    );
  }
}
