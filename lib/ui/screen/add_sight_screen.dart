import 'package:flutter/material.dart';
import 'package:places/ui/svg_icon.dart';

class AddSightScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        TextButton(
                          child: Text(
                            'Отмена',
                            style: theme.textTheme.bodyText1,
                          ),
                          onPressed: () => throw UnimplementedError(),
                        ),
                        Expanded(child: Container()),
                      ],
                    ),
                  ),
                  Text(
                    'Новое место',
                    style: theme.appBarTheme.textTheme!.headline6,
                  ),
                  Expanded(child: Container()),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _FieldTitle('категория'),
                    TextButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Не выбрано',
                            style: theme.textTheme.bodyText1,
                          ),
                          SvgIcon('res/figma/Icons/Icon/View.svg'),
                        ],
                      ),
                      onPressed: () => throw UnimplementedError(),
                    ),
                    _FieldTitle('название'),
                    TextField(
                      autofocus: true,
                      textInputAction: TextInputAction.next,
                    ),
                    Row(children: [
                      Expanded(child: _FieldTitle('широта')),
                      SizedBox(width: 16),
                      Expanded(child: _FieldTitle('долгота')),
                    ]),
                    Row(children: [
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                    ]),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                          child: Text(
                            'Указать на карте',
                            style: theme.accentTextTheme.button,
                          ),
                          onPressed: () => throw UnimplementedError(),
                        ),
                      ),
                    ),
                    _FieldTitle('описание'),
                    TextField(
                      minLines: 3,
                      maxLines: null,
                      decoration: InputDecoration(hintText: 'введите текст'),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: ElevatedButton(
                child: Text('СОЗДАТЬ'),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FieldTitle extends StatelessWidget {
  const _FieldTitle(
    this.label, {
    Key? key,
  }) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 12),
      child: Text(
        label.toUpperCase(),
        style: theme.textTheme.headline5,
      ),
    );
  }
}
