import 'package:places/domain/category.dart';
import 'package:places/domain/geo_position.dart';
import 'package:places/domain/sight.dart';
import 'dart:math';
// ignore: import_of_legacy_library_into_null_safe
import 'package:lorem_cutesum/lorem_cutesum.dart';

Random _rand = new Random();

String _randomWords([int from = 1, int to = 0]) {
  var num = from;
  if (from < to) {
    num = from + _rand.nextInt(to - from + 1);
  }

  final sentence = Cutesum.loremCutesum(words: num);
  return sentence.substring(0, sentence.length - 1);
}

List<Sight> generateMocks(int count) {
  return [
    for (var i = 0; i < count; i++)
      Sight(
        _randomWords(1, 4),
        geo: GeoPosition(
            (_rand.nextDouble() - .5) * 180, (_rand.nextDouble() - .5) * 360),
        url: Cutesum.randomImageUrl(),
        details: _randomWords(10, 50),
        type: categories.keys.toList()[_rand.nextInt(categories.length)],
      )
  ];
}
