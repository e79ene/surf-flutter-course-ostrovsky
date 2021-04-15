import 'package:flutter/material.dart';
import 'package:places/domain/sights_finder.dart';
import 'package:places/ui/bottom_navigation_view.dart';
import 'package:places/ui/res/my_icons.dart';
import 'package:places/ui/res/text_kit.dart';
import 'package:places/ui/res/themes.dart';
import 'package:places/ui/screen/widget/sight_card.dart';
import 'package:places/ui/screen/widget/search_bar.dart';
import 'package:places/ui/svg_icon.dart';

class SightListScreen extends StatefulWidget {
  @override
  _SightListScreenState createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  @override
  void initState() {
    sightsFinder.addListener(() => setState(() {}));
    super.initState();
  }

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
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: SightCard(
                    sightsFinder.filtered[index],
                    actions: [
                      IconButton(
                        icon: SvgIcon(MyIcons.Heart),
                        onPressed: () => throw UnimplementedError(),
                      ),
                    ],
                    afterTitle: Text(
                      sightsFinder.filtered[index].shortDescription,
                      style: theme.text.small.withColor(theme.color.secondary2),
                    ),
                  ),
                ),
                childCount: sightsFinder.filtered.length,
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _AddSightButton(),
      bottomNavigationBar: BottomNavigationView(),
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
        onPressed: () => UnimplementedError(),
      ),
    );
  }
}
