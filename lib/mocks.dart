import 'package:places/domain/category.dart';
import 'package:places/domain/geo_position.dart';
import 'package:places/domain/sight.dart';
import 'dart:math';
// ignore: import_of_legacy_library_into_null_safe
import 'package:lorem_cutesum/lorem_cutesum.dart';

final mocks = generateMocks(10);

Random rand = new Random();

String randomWords([int from = 1, int to = 0]) {
  var num = from;
  if (from < to) {
    num = from + rand.nextInt(to - from + 1);
  }

  final sentence = Cutesum.loremCutesum(words: num);
  return sentence.substring(0, sentence.length - 1);
}

List<Sight> generateMocks(int count) {
  return [
    for (var i = 0; i < count; i++)
      Sight(
        randomWords(1, 4),
        geo: GeoPosition(
            (rand.nextDouble() - .5) * 180, (rand.nextDouble() - .5) * 360),
        url: Cutesum.randomImageUrl(),
        details: randomWords(10, 50),
        type: categories.keys.toList()[rand.nextInt(categories.length)],
      )
  ];
}
