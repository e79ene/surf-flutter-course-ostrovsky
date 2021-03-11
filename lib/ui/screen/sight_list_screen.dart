import 'package:flutter/material.dart';

class SightListScreen extends StatefulWidget {
  @override
  _SightListScreenState createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  @override
  Widget build(BuildContext context) {
    print(Theme.of(context).dialogBackgroundColor);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        toolbarHeight: 100,
        title: RichText(
          text: TextSpan(
              style: TextStyle(
                color: Colors.black,
                fontSize: 32,
              ),
              children: [
                TextSpan(
                  text: 'С',
                  style: TextStyle(color: Colors.green),
                ),
                TextSpan(text: 'писок\n'),
                TextSpan(
                  text: 'и',
                  style: TextStyle(color: Colors.yellow),
                ),
                TextSpan(text: 'нтересных мест'),
              ]),
        ),
      ),
      body: Text('body'),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.ac_unit_outlined),
        onPressed: () {},
      ),
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(
          label: 'One',
          icon: Icon(Icons.access_alarms),
        ),
        BottomNavigationBarItem(
          label: 'Two',
          icon: Icon(Icons.access_time),
        ),
      ]),
    );
  }
}
