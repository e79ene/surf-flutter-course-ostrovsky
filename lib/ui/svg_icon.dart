import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgIcon extends StatelessWidget {
  final String assetName;

  SvgIcon(this.assetName);

  @override
  Widget build(BuildContext context) {
    final iconColor = IconTheme.of(context).color;

    return SvgPicture.asset(assetName, color: iconColor);
  }
}
