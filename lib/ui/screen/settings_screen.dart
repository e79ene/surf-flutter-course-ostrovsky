import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:places/ui/bottom_navigation_view.dart';
import 'package:places/ui/res/my_icons.dart';
import 'package:places/ui/res/text_kit.dart';
import 'package:places/ui/res/themes.dart';
import 'package:places/ui/screen/onboarding_screen.dart';
import 'package:places/ui/screen/widget/my_app_bar.dart';
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
      appBar: MyAppBar(title: 'Настройки'),
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
                  child: SvgIcon(MyIcons.info),
                  style: theme.textButtonGreen,
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => OnboardingScreen()),
                  ),
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
