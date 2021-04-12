import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:places/ui/res/my_icons.dart';
import 'package:places/ui/screen/filters_screen.dart';
import 'package:places/ui/screen/sight_search_screen.dart';
import 'package:places/ui/res/text_kit.dart';
import 'package:places/ui/res/themes.dart';
import 'package:places/ui/svg_icon.dart';

class SearchBar extends StatelessWidget implements PreferredSizeWidget {
  SearchBar({
    Key? key,
    this.controller,
    this.focusNode,
    this.onSearch,
  }) : super(key: key);

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final void Function(String)? onSearch;

  bool get enabled => onSearch != null;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget searchBar = TextField(
      enabled: enabled,
      controller: controller,
      focusNode: focusNode,
      onSubmitted: (value) => _search(value),
      inputFormatters: [
        TextInputFormatter.withFunction((oldValue, newValue) {
          if (_wordsChanged(oldValue, newValue)) _search(newValue.text);
          return newValue;
        })
      ],
      decoration: InputDecoration(
        isDense: true,
        filled: true,
        fillColor: theme.color.card,
        border: fieldBorder,
        enabledBorder: fieldBorder,
        focusedBorder: fieldBorder,
        disabledBorder: fieldBorder,
        contentPadding: EdgeInsets.symmetric(vertical: 13),
        prefixIcon: SizedBox(
          width: 50,
          child: Center(
            child: SvgIcon(
              MyIcons.Search,
              color: theme.color.inactiveBlack,
            ),
          ),
        ),
        hintText: 'Поиск',
        hintStyle: theme.text.text.withColor(theme.color.inactiveBlack),
        suffixIcon: SizedBox(
          width: 50,
          child: Center(
            child: enabled ? buildClearButton(theme) : null,
          ),
        ),
      ),
    );

    if (!enabled) {
      searchBar = Stack(
        children: [
          GestureDetector(
            child: searchBar,
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => SightSearchScreen()),
            ),
          ),
          Positioned(
            right: 5,
            child: buildFiltersButton(context, theme),
          ),
        ],
      );
    }

    return Padding(
      padding: EdgeInsets.only(top: 6, bottom: 14),
      child: searchBar,
    );
  }

  IconButton buildFiltersButton(BuildContext context, ThemeData theme) {
    return IconButton(
      icon: SvgIcon(
        MyIcons.Filter,
        color: theme.color.green,
      ),
      onPressed: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => FiltersScreen()),
      ),
    );
  }

  IconButton buildClearButton(ThemeData theme) => IconButton(
        icon: SvgIcon(
          MyIcons.clear,
          color: theme.textButtonTheme.style!.foregroundColor!.resolve({}),
        ),
        onPressed: () => controller?.clear(),
      );

  @override
  Size get preferredSize => Size.fromHeight(60);

  final fieldBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(style: BorderStyle.none),
  );

  void _search(String text) {
    onSearch!.call(text.trim());
  }

  static bool _wordsChanged(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    //ToDo: Decide when to make search
    return false;
  }
}
