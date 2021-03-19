import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/global_theme.dart';

class SightCard extends StatelessWidget {
  final Sight _sight;

  SightCard(this._sight);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 16),
      child: AspectRatio(
        aspectRatio: 3 / 2,
        child: ClipRect(
          child: OverflowBox(
            maxHeight: double.infinity,
            alignment: Alignment.topCenter,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Stack(children: [
                  Container(
                    width: double.infinity,
                    height: 100,
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(9)),
                      child: Image.network(
                        _sight.url,
                        fit: BoxFit.cover,
                        loadingBuilder: (BuildContext ctx, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
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
                SizedBox(height: 16),
                UnconstrainedBox(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * .78,
                    ),
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
