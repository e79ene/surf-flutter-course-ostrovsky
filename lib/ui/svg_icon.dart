import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgIcon extends StatelessWidget {
  final String assetName;
  final Color? color;

  SvgIcon(
    this.assetName, {
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final iconColor = color ?? IconTheme.of(context).color;

    return SvgPicture.asset(assetName, color: iconColor);
  }
}
