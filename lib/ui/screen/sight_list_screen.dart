import 'package:flutter/material.dart';
import 'package:places/domain/sights_finder.dart';
import 'package:places/ui/bottom_navigation_view.dart';
import 'package:places/ui/screen/sight_card.dart';
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
    return Scaffold(
      appBar: _Bar(
        title: 'Список\nинтересных мест',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            children: [
              for (var sight in sightsFinder.result)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: SightCard(
                    sight,
                    actions: [
                      IconButton(
                        icon: SvgIcon('res/figma/Icons/Icon/Heart.svg'),
                        onPressed: () {},
                      ),
                    ],
                    afterTitle: Text(sight.details),
                  ),
                )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationView(),
    );
  }
}

class _Bar extends StatelessWidget implements PreferredSizeWidget {
  static const height = 136.0;
  final String title;

  _Bar({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: EdgeInsets.all(16),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 32,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
