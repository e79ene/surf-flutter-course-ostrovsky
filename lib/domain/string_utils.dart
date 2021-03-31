import 'dart:math';

extension StringUtils on String {
  String left(int length) => substring(0, min(length, this.length));
}
