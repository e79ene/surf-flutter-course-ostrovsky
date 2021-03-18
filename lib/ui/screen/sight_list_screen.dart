import 'package:flutter/material.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/global_theme.dart';
import 'package:places/ui/screen/sight_card.dart';

class SightListScreen extends StatefulWidget {
  @override
  _SightListScreenState createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
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
            children: [for (var sight in mocks) SightCard(sight)],
          ),
        ),
      ),
    );
  }
}

class _Bar extends StatelessWidget implements PreferredSizeWidget {
  static const double height = barHeight;
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
          style: TextStyle(fontSize: 32),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
