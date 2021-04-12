import 'package:flutter/material.dart';
import 'package:places/domain/sights_finder.dart';
import 'package:places/ui/bottom_navigation_view.dart';
import 'package:places/ui/res/text_kit.dart';
import 'package:places/ui/res/themes.dart';
import 'package:places/ui/screen/widget/sight_card.dart';
import 'package:places/ui/screen/widget/my_app_bar.dart';
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
      appBar: MyAppBar(
        titleWidget: PreferredSize(
          preferredSize: Size.fromHeight(136),
          child: Container(
            padding: EdgeInsets.only(bottom: 16),
            alignment: Alignment.bottomLeft,
            child:
                Text('Список\nинтересных мест', style: theme.text.largeTitle),
          ),
        ),
        bottom: SearchBar(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            children: [
              for (var sight in sightsFinder.filtered)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: SightCard(
                    sight,
                    actions: [
                      IconButton(
                        icon: SvgIcon('res/figma/Icons/Icon/Heart.svg'),
                        onPressed: () => print('Heart'),
                      ),
                    ],
                    afterTitle: Text(
                      sight.shortDescription,
                      style: theme.text.small.withColor(theme.color.secondary2),
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _AddSightButton(),
      bottomNavigationBar: BottomNavigationView(),
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
          'res/figma/Icons/Icon/Plus.svg',
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
