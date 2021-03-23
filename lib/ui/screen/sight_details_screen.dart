import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/global_theme.dart';
import 'package:places/ui/image_loading_progress.dart';

class SightDetailsScreen extends StatelessWidget {
  final Sight _sight;

  SightDetailsScreen(this._sight);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: Image.network(
                    _sight.url,
                    fit: BoxFit.cover,
                    loadingBuilder: imageLoadingProgress,
                  ),
                ),
                Positioned(
                  top: 25,
                  left: 10,
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                    ),
                    onPressed: () {},
                    color: onImageElementColor,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    _sight.name,
                    style: sightScreenNameStyle,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4, bottom: 20),
                    child: Row(
                      children: [
                        Text(
                          _sight.type,
                          style: sightScreenTypeStyle,
                        ),
                        SizedBox(width: 20),
                        Text(
                          'Закрыто до 09:00',
                          style: sightClosedStyle,
                        ),
                      ],
                    ),
                  ),
                  Text(_sight.details),
                  Container(
                    margin: EdgeInsets.only(top: 20, bottom: 25),
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: routeButtonBackground,
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add_road,
                          color: routeButtonForeground,
                        ),
                        Text(
                          ' ПОСТРОИТЬ МАРШРУТ',
                          style: routeButtonStyle,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Icon(
                              Icons.calendar_today,
                              color: disabledButtonForeground,
                            ),
                            Text(
                              ' Запланировать',
                              style: disabledButtonStyle,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          children: [
                            Icon(Icons.favorite_border),
                            Text(' В избранное'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
