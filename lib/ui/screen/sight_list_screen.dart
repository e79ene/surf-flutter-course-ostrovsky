import 'package:flutter/material.dart';

class SightListScreen extends StatefulWidget {
  @override
  _SightListScreenState createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('appBar'),
        actions: [
          IconButton(
            icon: Icon(Icons.access_alarm),
            onPressed: () {},
          ),
        ],
      ),
      body: Text('body'),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.ac_unit_outlined),
        onPressed: () {},
      ),
      drawer: Drawer(
        child: Text('drawer'),
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
