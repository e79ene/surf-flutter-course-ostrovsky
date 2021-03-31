import 'package:flutter/material.dart';
import 'package:places/ui/svg_icon.dart';

class AddSightScreen extends StatefulWidget {
  @override
  _AddSightScreenState createState() => _AddSightScreenState();
}

class _AddSightScreenState extends State<AddSightScreen> {
  _AddSightScreenState() {
    details = _Field(
      title: 'описание',
      minLines: 3,
      next: null,
    );

    lon = _Field(
      title: 'долгота',
      keyboardType: TextInputType.number,
      next: details,
    );

    lat = _Field(
      title: 'широта',
      keyboardType: TextInputType.number,
      next: lon,
    );

    name = _Field(
      title: 'название',
      autofocus: true,
      next: lat,
    );
  }

  late final _Field name;
  late final _Field lat;
  late final _Field lon;
  late final _Field details;
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    for (final field in [name, lat, lon, details]) field.focus.dispose();

    super.dispose();
  }

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
                child: Form(
                  key: formKey,
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
                      name.build(),
                      Row(children: [
                        Expanded(child: lat.build()),
                        SizedBox(width: 16),
                        Expanded(child: lon.build()),
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
                      details.build(),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: ElevatedButton(
                child: Text('СОЗДАТЬ'),
                onPressed: () {
                  if (formKey.currentState!.validate()) saveSight();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void saveSight() {
    throw UnimplementedError();
  }
}

@immutable
class _Field {
  _Field({
    required this.title,
    this.autofocus = false,
    this.keyboardType,
    this.minLines,
    required this.next,
  });

  final focus = FocusNode();
  final String title;
  final bool autofocus;
  final TextInputType? keyboardType;
  final int? minLines;
  final _Field? next;

  Widget build() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _FieldTitle(title),
        TextField(
          autofocus: autofocus,
          focusNode: focus,
          keyboardType: keyboardType,
          onEditingComplete: next != null
              ? () => next!.focus.requestFocus()
              : () => focus.unfocus(),
          textInputAction:
              next != null ? TextInputAction.next : TextInputAction.done,
          minLines: minLines,
          maxLines: minLines == null ? 1 : null,
          decoration: InputDecoration(
            hintText: minLines != null ? 'введите текст' : null,
          ),
        ),
      ],
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
