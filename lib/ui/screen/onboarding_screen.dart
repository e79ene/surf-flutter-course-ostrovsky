import 'package:flutter/material.dart';
import 'package:places/ui/res/my_icons.dart';
import 'package:places/ui/res/text_kit.dart';
import 'package:places/ui/res/themes.dart';
import 'package:places/ui/screen/widget/my_app_bar.dart';
import 'package:places/ui/svg_icon.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController controller = PageController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final indicator = _Indicator(controller, 3);

    return PageView(
      controller: controller,
      children: [
        _Page(
          assetName: MyIcons.Tutorial1,
          title: 'Добро пожаловать в Путеводитель',
          details: 'Ищи новые локации и сохраняй самые любимые. ',
          indicator: indicator,
        ),
        _Page(
          assetName: MyIcons.Tutorial2,
          title: 'Построй маршрут и отправляйся в путь',
          details: 'Достигай цели максимально быстро и комфортно.',
          indicator: indicator,
        ),
        _Page(
          assetName: MyIcons.Tutorial3,
          title: 'Добавляй места, которые нашёл сам',
          details: 'Делись самыми интересными и помоги нам стать лучше!',
          indicator: indicator,
          isLast: true,
        ),
      ],
    );
  }
}

class _Page extends StatelessWidget {
  const _Page({
    Key? key,
    required this.assetName,
    required this.title,
    required this.details,
    required this.indicator,
    this.isLast = false,
  }) : super(key: key);

  final String assetName;
  final String title;
  final String details;
  final Widget indicator;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: MyAppBar(
        title: '',
        trailing: isLast
            ? null
            : TextButton(
                child: Text('Пропустить'),
                style: TextButton.styleFrom(
                  primary: theme.color.green,
                ),
                onPressed: _finish,
              ),
      ),
      body: Center(
        child: Column(children: [
          Spacer(flex: 3),
          SvgIcon(assetName),
          SizedBox(height: 40),
          SizedBox(
            width: 244,
            child: Text(
              title,
              style: theme.text.title.withColor(theme.color.title),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 8),
          SizedBox(
            width: 234,
            child: Text(
              details,
              style: theme.text.small.withColor(theme.color.secondary2),
              textAlign: TextAlign.center,
            ),
          ),
          Spacer(flex: 2),
        ]),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 56,
            alignment: Alignment.center,
            child: indicator,
          ),
          Container(
            height: 64,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: isLast
                ? ElevatedButton(
                    onPressed: _finish,
                    child: Text('НА СТАРТ'),
                  )
                : null,
          ),
        ],
      ),
    );
  }

  void _finish() => throw UnimplementedError();
}

class _Indicator extends StatefulWidget {
  _Indicator(this.controller, this.pageCount);

  final PageController controller;
  final int pageCount;

  @override
  _IndicatorState createState() => _IndicatorState();
}

class _IndicatorState extends State<_Indicator> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() => setState(() {}));
  }

  int get page =>
      widget.controller.hasClients ? widget.controller.page?.round() ?? 0 : 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0; i < widget.pageCount; i++)
          Container(
            width: (i == page) ? 24 : 8,
            height: 8,
            margin: EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              color:
                  (i == page) ? theme.color.green : theme.color.inactiveBlack,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
      ],
    );
  }
}
