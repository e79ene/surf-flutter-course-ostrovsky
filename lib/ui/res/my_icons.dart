import 'package:flutter/cupertino.dart';

class MyIcons {
  static const baseDir = 'res/figma/Icons';
  static const IconDir = '$baseDir/Icon';
  static const Arrow = '$IconDir/Arrow.svg';
  static const Calendar = '$IconDir/Calendar.svg';
  static const Camera = '$IconDir/Camera.svg';
  static const clear = '$IconDir/clear.svg';
  static const Close = '$IconDir/Close.svg';
  static const Delete = '$IconDir/Delete.svg';
  static const Fail = '$IconDir/Fail.svg';
  static const Filter = '$IconDir/Filter.svg';
  static const GO = '$IconDir/GO.svg';
  static const Heart = '$IconDir/Heart.svg';
  static const Heart_Full = '$IconDir/Heart Full.svg';
  static const info = '$IconDir/info.svg';
  static const List = '$IconDir/List.svg';
  static const List_Full = '$IconDir/List Full.svg';
  static const Map_Full = '$IconDir/Map Full.svg';
  static const Photo = '$IconDir/Photo.svg';
  static const Plus = '$IconDir/Plus.svg';
  static const Search = '$IconDir/Search.svg';
  static const Settings = '$IconDir/Settings.svg';
  static const Settings_fill = '$IconDir/Settings-fill.svg';
  static const Share = '$IconDir/Share.svg';
  static const View = '$IconDir/View.svg';
  static const Tutorial1 = '$baseDir/Tutorial 1 frame.svg';
  static const Tutorial2 = '$baseDir/Tutorial 2 frame.svg';
  static const Tutorial3 = '$baseDir/Tutorial 3 frame.svg';

  static String forCategory(Brightness brightness, String assetName) =>
      'res/figma/Icons/Catalog/' +
      ((brightness == Brightness.dark) ? 'Black' : 'White') +
      '/$assetName.svg';
}
