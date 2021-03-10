import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: MyFirstWidget(),
      home: MyFullWidget(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

// ignore: must_be_immutable
class MyFirstWidget extends StatelessWidget {
  static int staticCounter = 0;
  int inWidgetCounter = 0;
  @override
  Widget build(BuildContext context) {
    staticCounter++;
    inWidgetCounter++;
    print('Counter staic:$staticCounter in widget:$inWidgetCounter');

    return Container(
      child: Center(
        child: Text('Hello Stateless!'),
      ),
    );
  }
}

class MyFullWidget extends StatefulWidget {
  static int staticCounter = 0;
  int inWidgetCounter = 0;

  @override
  _MyFullWidgetState createState() => _MyFullWidgetState();
}

class _MyFullWidgetState extends State<MyFullWidget> {
  int inStateCounter = 0;

  @override
  Widget build(BuildContext context) {
    MyFullWidget.staticCounter++;
    widget.inWidgetCounter++;
    inStateCounter++;
    print('Counter staic:${MyFullWidget.staticCounter}'
        ' in widget:${widget.inWidgetCounter} in state:$inStateCounter');

    return Container(
      child: Center(
        child: Text('Hello Statefull!'),
      ),
    );
  }
}
