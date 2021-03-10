import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Заголовок',
      home: MyFirstWidget(),
    );
  }
}

// ignore: must_be_immutable
class MyFirstWidget extends StatelessWidget {
  static int staticCounter = 0;
  int inWidgetCounter = 0;

  /* ОШИБКА: undefined name 'context'
  Type contextType() {
    return context.runtimeType;
  }
  */

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

// ignore: must_be_immutable
class MyFullWidget extends StatefulWidget {
  static int staticCounter = 0;
  int inWidgetCounter = 0;

  /* ОШИБКА: undefined name 'context'
  Type contextType() {
    return context.runtimeType;
  }
  */

  @override
  _MyFullWidgetState createState() => _MyFullWidgetState();
}

class _MyFullWidgetState extends State<MyFullWidget> {
  int inStateCounter = 0;

  Type contextType() {
    // Ok
    return context.runtimeType;
  }

  @override
  Widget build(BuildContext context) {
    MyFullWidget.staticCounter++;
    widget.inWidgetCounter++;
    inStateCounter++;
    print('Counter staic:${MyFullWidget.staticCounter}'
        ' in widget:${widget.inWidgetCounter} in state:$inStateCounter');

    return Container(
      child: Center(
        child: Text('Hello Stateful!'),
      ),
    );
  }
}
