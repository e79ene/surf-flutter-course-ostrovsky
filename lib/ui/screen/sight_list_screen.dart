import 'package:flutter/material.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/model/place.dart';
import 'package:places/ui/bottom_navigation_view.dart';
import 'package:places/ui/res/my_icons.dart';
import 'package:places/ui/res/text_kit.dart';
import 'package:places/ui/res/themes.dart';
import 'package:places/ui/screen/add_sight_screen.dart';
import 'package:places/ui/screen/widget/error_view.dart';
import 'package:places/ui/screen/widget/favorite_icon.dart';
import 'package:places/ui/screen/widget/sight_card.dart';
import 'package:places/ui/screen/widget/search_bar.dart';
import 'package:places/ui/svg_icon.dart';
import 'package:relation/relation.dart';

class SightListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 152,
            collapsedHeight: 56,
            flexibleSpace: _ScalingBar(),
          ),
          SliverPadding(
            padding: EdgeInsets.all(16),
            sliver: SliverToBoxAdapter(child: SearchBar()),
          ),
          EntityStateBuilder(
            streamedState: placeInteractor.filteredPlaces,
            child: (_, List<Place>? places) => buildList(theme, places!),
            loadingChild: buildStateIndicator(CircularProgressIndicator()),
            errorChild: buildStateIndicator(ErrorView()),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _AddSightButton(),
      bottomNavigationBar: BottomNavigationView.list(),
    );
  }

  Widget buildStateIndicator(Widget child) {
    return SliverFillRemaining(
      child: Container(
        padding: EdgeInsets.only(bottom: 70),
        alignment: Alignment.center,
        child: child,
      ),
    );
  }

  Widget buildList(ThemeData theme, List<Place> places) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 400,
          crossAxisSpacing: 36,
          mainAxisExtent: 212,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final place = places[index];

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: SightCard(
                place,
                actions: [
                  StreamedStateBuilder(
                    streamedState: placeInteractor.favorite,
                    builder: (_, List<Place>? places) => IconButton(
                      icon: FavoriteIcon(place),
                      onPressed: () => placeInteractor.toggleFavorite(place),
                    ),
                  ),
                ],
                afterTitle: Text(
                  place.description,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.text.small.withColor(theme.color.secondary2),
                ),
              ),
            );
          },
          childCount: places.length,
        ),
      ),
    );
  }
}

class _ScalingBar extends StatelessWidget {
  const _ScalingBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final FlexibleSpaceBarSettings settings =
        context.dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>()!;
    final double deltaExtent = settings.maxExtent - settings.minExtent;

    // 0.0 -> Expanded
    // 1.0 -> Collapsed
    final double t =
        (1.0 - (settings.currentExtent - settings.minExtent) / deltaExtent)
            .clamp(0.0, 1.0);

    return Container(
      padding: EdgeInsets.all(16),
      alignment:
          Alignment.lerp(Alignment.bottomLeft, Alignment.bottomCenter, t),
      child: Text(
        'Список интересных мест',
        style: TextStyle.lerp(theme.text.largeTitle, theme.text.subTitle, t),
      ),
    );
  }
}

class _AddSightButton extends StatelessWidget {
  const _AddSightButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: ShapeDecoration(
        shape: StadiumBorder(),
        gradient: LinearGradient(colors: [
          theme.color.yellow,
          theme.color.green,
        ]),
      ),
      child: FloatingActionButton.extended(
        backgroundColor: Colors.transparent,
        icon: SvgIcon(
          MyIcons.Plus,
          color: theme.color.white,
        ),
        label: Text(
          'НОВОЕ МЕСТО',
          style: theme.elevatedButtonTheme.style!.textStyle!.resolve({}),
        ),
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => AddSightScreen()),
        ),
      ),
    );
  }
}
