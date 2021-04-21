import 'package:flutter/material.dart';
import 'package:places/data/model/place.dart';
import 'package:places/ui/image_loading_progress.dart';
import 'package:places/ui/res/themes.dart';
import 'package:places/ui/screen/widget/sight_details_view.dart';

class SightDetailsScreen extends StatelessWidget {
  final Place _sight;

  SightDetailsScreen(this._sight);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SightDetailsView(_sight),
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
