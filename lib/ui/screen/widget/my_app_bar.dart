import 'package:flutter/material.dart';
import 'package:places/ui/my_back_button.dart';
import 'package:places/ui/res/themes.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? backLabel;
  final PreferredSizeWidget title;
  final Widget? trailing;
  final PreferredSizeWidget? bottom;
  final bool transparent;

  MyAppBar({
    this.backLabel,
    String? title,
    PreferredSizeWidget? titleWidget,
    this.trailing,
    this.bottom,
    this.transparent = false,
  })  : assert((title != null) ^ (titleWidget != null)),
        title = titleWidget ?? _DefaultTitle(title!);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final showBack = ModalRoute.of(context)?.canPop ?? false;

    Widget appBar = SizedBox(
      height: title.preferredSize.height,
      child: title,
    );

    if (showBack || trailing != null) {
      appBar = Row(
        children: [
          (!showBack)
              ? Spacer()
              : Expanded(
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: _buildBack(context, theme))),
          appBar,
          (trailing == null)
              ? Spacer()
              : Expanded(
                  child: Align(
                      alignment: Alignment.centerRight, child: trailing!)),
        ],
      );
    }

    if (bottom != null) {
      appBar = Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          appBar,
          bottom!,
        ],
      );
    }

    return SafeArea(
      child: Container(
        color: transparent ? null : theme.color.background,
        height: preferredSize.height,
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: appBar,
      ),
    );
  }

  Widget _buildBack(BuildContext context, ThemeData theme) =>
      (backLabel == null)
          ? MyBackButton()
          : TextButton(
              child: Text(
                backLabel!,
                style: theme.text.text,
              ),
              onPressed: () => Navigator.maybePop(context),
            );

  @override
  Size get preferredSize => Size.fromHeight(title.preferredSize.height +
      (bottom != null ? bottom!.preferredSize.height : 0));
}

class _DefaultTitle extends StatelessWidget implements PreferredSizeWidget {
  const _DefaultTitle(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(title, style: Theme.of(context).text.subTitle),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60);
}
