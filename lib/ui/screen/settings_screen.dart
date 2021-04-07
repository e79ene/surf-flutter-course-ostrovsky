import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:places/ui/bottom_navigation_view.dart';
import 'package:places/ui/screen/theme/text_kit.dart';
import 'package:places/ui/screen/theme/themes.dart';
import 'package:places/ui/svg_icon.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    themeSwitcher.addListener(() => setState(() {}));
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
                  style: theme.text.text.withColor(theme.color.title),
                ),
                CupertinoSwitch(
                  value: themeSwitcher.isDark,
                  trackColor: theme.color.inactiveBlack,
                  activeColor: theme.color.green,
                  onChanged: (v) => themeSwitcher.isDark = v,
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Смотреть туториал',
                  style: theme.text.text.withColor(theme.color.title),
                ),
                TextButton(
                  child: SvgIcon('res/figma/Icons/Icon/info.svg'),
                  style: theme.textButtonGreen,
                  onPressed: () => throw UnimplementedError(),
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
