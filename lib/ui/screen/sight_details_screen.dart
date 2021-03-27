import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/image_loading_progress.dart';

class SightDetailsScreen extends StatelessWidget {
  final Sight _sight;

  SightDetailsScreen(this._sight);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
                  child: IconTheme(
                    data: theme.accentIconTheme,
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                      ),
                      onPressed: () {},
                    ),
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
                    style: theme.textTheme.headline2,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4, bottom: 20),
                    child: Row(
                      children: [
                        Text(
                          _sight.type,
                          style: theme.textTheme.headline1,
                        ),
                        SizedBox(width: 20),
                        Text(
                          'Закрыто до 09:00',
                          style: TextStyle(
                              color: theme
                                  .tabBarTheme.unselectedLabelStyle!.color),
                        ),
                      ],
                    ),
                  ),
                  Text(_sight.details),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: ElevatedButton.icon(
                      icon: Icon(Icons.add_road),
                      label: Text('ПОСТРОИТЬ МАРШРУТ'),
                      onPressed: () => print('ПОСТРОИТЬ МАРШРУТ'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton.icon(
                          icon: Icon(Icons.calendar_today),
                          label: Text('Запланировать'),
                          onPressed: null,
                        ),
                        TextButton.icon(
                          icon: Icon(Icons.favorite_border),
                          label: Text('В избранное'),
                          onPressed: () => print('В избранное'),
                        ),
                      ],
                    ),
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
