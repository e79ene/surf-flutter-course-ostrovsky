import 'package:flutter/material.dart';
import 'package:places/ui/res/my_icons.dart';
import 'package:places/ui/res/text_kit.dart';
import 'package:places/ui/res/themes.dart';
import 'package:places/ui/svg_icon.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            border: Border.all(
              width: 5,
              color: theme.color.inactiveBlack,
            ),
          ),
          child: OverflowBox(
            minHeight: 70,
            minWidth: 70,
            maxHeight: 70,
            maxWidth: 70,
            child: SvgIcon(MyIcons.Delete, color: theme.color.inactiveBlack),
          ),
        ),
        SizedBox(height: 24),
        Text(
          'Ошибка',
          style: theme.text.subTitle.withColor(theme.color.inactiveBlack),
        ),
        SizedBox(height: 8),
        SizedBox(
          width: 150,
          child: Text(
            'Что то пошло не так. Попробуйте позже.',
            textAlign: TextAlign.center,
            style: theme.text.small,
          ),
        ),
      ],
    );
  }
}
