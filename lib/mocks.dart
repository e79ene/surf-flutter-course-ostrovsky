import 'package:places/domain/category.dart';
import 'package:places/domain/geo_position.dart';
import 'package:places/domain/sight.dart';
import 'dart:math';
// ignore: import_of_legacy_library_into_null_safe
import 'package:lorem_cutesum/lorem_cutesum.dart';

Random _rand = new Random();

int _randomInt(int from, int to) =>
    (from >= to) ? from : from + _rand.nextInt(to - from + 1);

String _randomWords([int from = 1, int to = 0]) {
  final sentence = Cutesum.loremCutesum(words: _randomInt(from, to));
  return sentence.substring(0, sentence.length - 1);
}

List<String> _randomUrls(int count) => [
      for (var i = 0; i < count; i++) Cutesum.randomImageUrl(),
    ];

List<Sight> generateMocks(int count) {
  return [
    for (var i = 0; i < count; i++)
      Sight(
        _randomWords(1, 4),
        geo: GeoPosition(
            (_rand.nextDouble() - .5) * 180, (_rand.nextDouble() - .5) * 360),
        photoUrls: _randomUrls(_randomInt(1, 4)),
        details: _randomWords(150, 300),
        type: categories.keys.toList()[_rand.nextInt(categories.length)],
      )
  ];
}
