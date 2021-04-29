import 'package:flutter/material.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/model/place.dart';
import 'package:places/ui/image_loading_progress.dart';
import 'package:places/ui/my_back_button.dart';
import 'package:places/ui/res/my_icons.dart';
import 'package:places/ui/res/text_kit.dart';
import 'package:places/ui/res/themes.dart';
import 'package:places/ui/screen/widget/error_view.dart';
import 'package:places/ui/screen/widget/favorite_icon.dart';
import 'package:places/ui/svg_icon.dart';
import 'package:provider/provider.dart';

class SightDetailsView extends StatelessWidget {
  SightDetailsView(
    Place originalPlace, {
    Key? key,
    required this.deleteOption,
  })  : placeId = originalPlace.id,
        super(key: key);

  final int placeId;
  final bool deleteOption;

  @override
  Widget build(BuildContext context) {
    final placeInteractor = Provider.of<PlaceInteractor>(context);

    return FutureBuilder(
      future: placeInteractor.getPlaceDetails(placeId),
      builder: (context, AsyncSnapshot<Place> snapshot) => snapshot.hasData
          ? buildView(context, snapshot.data!)
          : Center(
              child:
                  snapshot.hasError ? ErrorView() : CircularProgressIndicator(),
            ),
    );
  }

  Widget buildView(BuildContext context, Place place) {
    final theme = Theme.of(context);
    final placeInteractor = Provider.of<PlaceInteractor>(context);

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 360,
          collapsedHeight: 64,
          flexibleSpace: _Gallery(place.urls),
          leading: Center(
              // Don't show in bottomSheets
              child: (ModalRoute.of(context) is PageRoute)
                  ? MyBackButton()
                  : null),
        ),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              if (deleteOption)
                Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: ElevatedButton(
                    child: Text('УДАЛИТЬ'),
                    style: ElevatedButton.styleFrom(primary: theme.color.red),
                    onPressed: () => placeInteractor.deleteById(place.id),
                  ),
                ),
              Text(
                place.name,
                style: theme.text.title,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4, bottom: 20),
                child: Row(
                  children: [
                    Text(
                      place.category.name,
                      style:
                          theme.text.smallBold.withColor(theme.color.secondary),
                    ),
                    SizedBox(width: 20),
                    Text(
                      'Закрыто до 09:00',
                      style: TextStyle(color: theme.color.inactiveBlack),
                    ),
                  ],
                ),
              ),
              Text(place.description,
                  style: TextStyle(color: theme.color.foreground)),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: ElevatedButton.icon(
                  icon: SvgIcon(MyIcons.GO),
                  label: Text('ПОСТРОИТЬ МАРШРУТ'),
                  onPressed: () =>
                      throw UnimplementedError('ПОСТРОИТЬ МАРШРУТ'),
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
                      icon: FavoriteIcon(place),
                      label: Text('В избранное'),
                      onPressed: () => placeInteractor.toggleFavorite(place),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ],
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
