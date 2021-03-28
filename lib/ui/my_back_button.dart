import 'package:flutter/material.dart';
import 'package:places/ui/svg_icon.dart';

class MyBackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ElevatedButton(
      child: SvgIcon('res/figma/Icons/Icon/Arrow.svg'),
      style: ElevatedButton.styleFrom(
        primary: theme.canvasColor,
        onPrimary: theme.bottomNavigationBarTheme.selectedItemColor,
        elevation: 0,
        fixedSize: Size.square(32),
        minimumSize: Size.square(32),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: () {},
    );
  }
}
