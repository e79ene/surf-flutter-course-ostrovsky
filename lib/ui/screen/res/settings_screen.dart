import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:places/ui/bottom_navigation_view.dart';
import 'package:places/ui/screen/res/themes.dart';
import 'package:places/ui/svg_icon.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    isDarkTheme.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text('Настройки')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Тёмная тема',
                  style: theme.textTheme.headline3,
                ),
                CupertinoSwitch(
                  value: isDarkTheme.value,
                  trackColor: theme.textTheme.headline5!.color,
                  activeColor: theme.accentColor,
                  onChanged: (v) => isDarkTheme.value = v,
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Смотреть туториал',
                  style: theme.textTheme.headline3,
                ),
                TextButton(
                  child: SvgIcon('res/figma/Icons/Icon/info.svg'),
                  style: TextButton.styleFrom(
                    primary: theme.accentColor,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationView(),
    );
  }
}
