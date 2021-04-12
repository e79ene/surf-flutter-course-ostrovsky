import 'package:flutter/material.dart';
import 'package:places/ui/res/themes.dart';
import 'package:places/ui/svg_icon.dart';

class MyBackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ElevatedButton(
      child: SvgIcon('res/figma/Icons/Icon/Arrow.svg'),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        primary: theme.color.background,
        onPrimary: theme.color.title,
        fixedSize: Size.square(32),
        minimumSize: Size.square(32),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ).copyWith(
        elevation: MaterialStateProperty.all(0),
      ),
      onPressed: () => Navigator.maybePop(context),
    );
  }
}
