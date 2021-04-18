import 'package:flutter/material.dart';
import 'package:places/ui/res/my_icons.dart';
import 'package:places/ui/res/themes.dart';
import 'package:places/ui/screen/onboarding_screen.dart';
import 'package:places/ui/svg_icon.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          theme.color.yellow,
          theme.color.green,
        ]),
      ),
      alignment: Alignment.center,
      child: Container(
        width: 160,
        height: 160,
        decoration: BoxDecoration(
          color: theme.color.white,
          borderRadius: BorderRadius.circular(80),
        ),
        alignment: Alignment.center,
        child: SizedBox(
          width: 100,
          height: 100,
          child: SvgIcon(
            MyIcons.Map_Full,
            color: theme.color.green,
          ),
        ),
      ),
    );
  }

  void _navigateToNext() async {
    // Simulate some initialization
    final dataLoading = Future(() {});

    // UX splash screen delay
    final uiWait = Future.delayed(Duration(seconds: 2), () {});

    await dataLoading;
    await uiWait;

    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => OnboardingScreen()),
    );
  }
}
