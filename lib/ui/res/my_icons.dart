import 'package:flutter/cupertino.dart';

class MyIcons {
  static const IconDir = 'res/figma/Icons/Icon';
  static const Arrow = '$IconDir/Arrow.svg';
  static const Calendar = '$IconDir/Calendar.svg';
  static const clear = '$IconDir/clear.svg';
  static const Close = '$IconDir/Close.svg';
  static const Delete = '$IconDir/Delete.svg';
  static const Filter = '$IconDir/Filter.svg';
  static const GO = '$IconDir/GO.svg';
  static const Heart = '$IconDir/Heart.svg';
  static const info = '$IconDir/info.svg';
  static const List = '$IconDir/List.svg';
  static const Plus = '$IconDir/Plus.svg';
  static const Search = '$IconDir/Search.svg';
  static const Settings = '$IconDir/Settings.svg';
  static const Share = '$IconDir/Share.svg';
  static const View = '$IconDir/View.svg';

  static String forCategory(Brightness brightness, String assetName) =>
      'res/figma/Icons/Catalog/' +
      ((brightness == Brightness.dark) ? 'Black' : 'White') +
      '/$assetName.svg';
}
