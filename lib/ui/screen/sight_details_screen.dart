import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/image_loading_progress.dart';
import 'package:places/ui/my_back_button.dart';
import 'package:places/ui/res/my_icons.dart';
import 'package:places/ui/res/text_kit.dart';
import 'package:places/ui/res/themes.dart';
import 'package:places/ui/svg_icon.dart';

class SightDetailsScreen extends StatelessWidget {
  final Sight _sight;

  SightDetailsScreen(this._sight);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 360,
            collapsedHeight: 64,
            flexibleSpace: _Gallery(_sight.photoUrls),
            leading: Center(child: MyBackButton()),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
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
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _Gallery extends StatefulWidget {
  const _Gallery(
    this.urls, {
    Key? key,
  }) : super(key: key);

  final List<String> urls;

  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<_Gallery> {
  static const double indicatorHeight = 8;
  static const indicatorRadius = indicatorHeight / 2;

  final controller = PageController();

  @override
  void initState() {
    super.initState();
    controller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  int get pageCount => widget.urls.length;
  int get page => controller.hasClients ? controller.page?.round() ?? 0 : 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView.builder(
          controller: controller,
          itemCount: widget.urls.length,
          itemBuilder: (context, index) => Image.network(
            widget.urls[index],
            fit: BoxFit.cover,
            loadingBuilder: imageLoadingProgress,
          ),
        ),
        if (pageCount > 1)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: indicatorHeight,
            child: Row(
              children: [
                for (int i = 0; i < pageCount; i++)
                  (i == page) ? buildThumb(context) : Spacer(),
              ],
            ),
          ),
      ],
    );
  }

  Widget buildThumb(BuildContext context) => Expanded(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              left: -indicatorRadius,
              right: -indicatorRadius,
              top: 0,
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).color.title,
                  borderRadius: BorderRadius.circular(indicatorRadius),
                ),
              ),
            ),
          ],
        ),
      );
}
