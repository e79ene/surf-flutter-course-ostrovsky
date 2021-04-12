import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/image_loading_progress.dart';
import 'package:places/ui/res/my_icons.dart';
import 'package:places/ui/res/text_kit.dart';
import 'package:places/ui/res/themes.dart';
import 'package:places/ui/screen/widget/my_app_bar.dart';
import 'package:places/ui/svg_icon.dart';

class SightDetailsScreen extends StatelessWidget {
  final Sight _sight;

  SightDetailsScreen(this._sight);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: MyAppBar(title: '', transparent: true),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Image.network(
                _sight.url,
                fit: BoxFit.cover,
                loadingBuilder: imageLoadingProgress,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    _sight.name,
                    style: theme.text.title,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4, bottom: 20),
                    child: Row(
                      children: [
                        Text(
                          _sight.type,
                          style: theme.text.smallBold
                              .withColor(theme.color.secondary),
                        ),
                        SizedBox(width: 20),
                        Text(
                          'Закрыто до 09:00',
                          style: TextStyle(color: theme.color.inactiveBlack),
                        ),
                      ],
                    ),
                  ),
                  Text(_sight.details,
                      style: TextStyle(color: theme.color.foreground)),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: ElevatedButton.icon(
                      icon: SvgIcon(MyIcons.GO),
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
                          icon: SvgIcon(MyIcons.Calendar),
                          label: Text('Запланировать'),
                          onPressed: null,
                        ),
                        TextButton.icon(
                          icon: SvgIcon(MyIcons.Heart),
                          label: Text('В избранное'),
                          onPressed: () => throw UnimplementedError(),
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
