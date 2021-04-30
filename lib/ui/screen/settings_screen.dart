import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:places/data/interactor/theme_interactor.dart';
import 'package:places/ui/bottom_navigation_view.dart';
import 'package:places/ui/res/my_icons.dart';
import 'package:places/ui/res/text_kit.dart';
import 'package:places/ui/res/themes.dart';
import 'package:places/ui/screen/onboarding_screen.dart';
import 'package:places/ui/screen/widget/my_app_bar.dart';
import 'package:places/ui/svg_icon.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
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
                Consumer<ThemeInteractor>(
                  builder: (_, themeInteractor, __) => CupertinoSwitch(
                    value: themeInteractor.isDark,
                    trackColor: theme.color.inactiveBlack,
                    activeColor: theme.color.green,
                    onChanged: (v) => themeInteractor.isDark = v,
                  ),
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
      bottomNavigationBar: BottomNavigationView.settings(),
    );
  }
}
