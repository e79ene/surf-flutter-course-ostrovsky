import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:lorem_cutesum/lorem_cutesum.dart';
import 'package:places/ui/res/my_icons.dart';
import 'package:places/ui/res/themes.dart';
import 'package:places/ui/svg_icon.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          theme.color.yellow,
          theme.color.green,
        ]),
      ),
      alignment: Alignment.center,
      child: Container(
        width: 160,
        height: 160,
        decoration: BoxDecoration(
          color: theme.color.white,
          borderRadius: BorderRadius.circular(80),
        ),
        alignment: Alignment.center,
        child: SizedBox(
          width: 100,
          height: 100,
          child: SvgIcon(
            MyIcons.Map_Full,
            color: theme.color.green,
          ),
        ),
      ),
    );
  }

  void _navigateToNext() async {
    // UX splash screen delay
    final uiWait = Future.delayed(Duration(seconds: 2), () {});

    // _doWork('synchronously');

    // Future(() => _doWork('in Future'));

    compute(_doWork, 'in isolate');

    await uiWait;

    print('Переход на следующий экран');
  }
}

void _doWork(String method) {
  print('Working $method...');

  final strings = _generateStrings(1000000);
  final res = _revertStrigs(strings);

  print('Finished with ${res.length} stirngs');
}

Iterable<String> _generateStrings(int count) => [
      for (int i = 0; i < count; i++) Cutesum.loremCutesum(words: 1),
    ];

Iterable<String> _revertStrigs(Iterable<String> strings) => [
      for (final s in strings)
        String.fromCharCodes(bubbleSort(s.runes.toList())),
    ];

List<int> bubbleSort(List<int> list) {
  int n = list.length;
  int i, step;
  for (step = 0; step < n; step++) {
    for (i = 0; i < n - step - 1; i++) {
      if (list[i] > list[i + 1]) {
        swap(list, i);
      }
    }
  }
  return list;
}

void swap(List list, int i) {
  int temp = list[i];
  list[i] = list[i + 1];
  list[i + 1] = temp;
}
