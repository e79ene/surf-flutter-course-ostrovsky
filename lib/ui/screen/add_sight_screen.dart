import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:lorem_cutesum/lorem_cutesum.dart';
import 'package:places/domain/geo_position.dart';
import 'package:places/domain/sight.dart';
import 'package:places/domain/sight_repo.dart';
import 'package:places/ui/image_loader.dart';
import 'package:places/ui/res/text_kit.dart';
import 'package:places/ui/res/themes.dart';
import 'package:places/ui/screen/widget/my_app_bar.dart';
import 'package:places/ui/svg_icon.dart';

class AddSightScreen extends StatefulWidget {
  @override
  _AddSightScreenState createState() => _AddSightScreenState();
}

class _AddSightScreenState extends State<AddSightScreen> {
  late final _Field name, lat, lon, details;
  late final List<_Field> _fields;
  final formKey = GlobalKey<FormState>();
  final photoUrls = <String>[];

  _AddSightScreenState() {
    details = _Field(
      title: 'описание',
      onValidChange: () => setState(() {}),
      minLines: 3,
      next: null,
    );

    lon = _Field(
      title: 'долгота',
      onValidChange: () => setState(() {}),
      validator: _rangeValidator(-180, 360),
      next: details,
    );

    lat = _Field(
      title: 'широта',
      onValidChange: () => setState(() {}),
      validator: _rangeValidator(-90, 90),
      next: lon,
    );

    name = _Field(
      title: 'название',
      onValidChange: () => setState(() {}),
      autofocus: true,
      next: lat,
    );

    _fields = [name, lat, lon, details];
  }

  @override
  void dispose() {
    for (final field in _fields) field.dispose();

    super.dispose();
  }

  bool get isValid => _fields.every((field) => field.isValid);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: MyAppBar(
        backLabel: 'Отмена',
        title: 'Новое место',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 24),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => addPhoto(),
                        child: Container(
                          width: 72,
                          height: 72,
                          decoration: BoxDecoration(
                            border: Border.all(color: theme.color.green),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.add,
                            size: 50,
                            color: theme.color.green,
                          ),
                        ),
                      ),
                      for (final url in photoUrls)
                        _Photo(
                          url,
                          onDeleteRequest: () =>
                              setState(() => photoUrls.remove(url)),
                        ),
                    ],
                  ),
                ),
                _FieldTitle('категория'),
                TextButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Не выбрано',
                        style:
                            theme.text.text.withColor(theme.color.secondary2),
                      ),
                      SvgIcon('res/figma/Icons/Icon/View.svg'),
                    ],
                  ),
                  onPressed: () => throw UnimplementedError(),
                ),
                name.build(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: lat.build()),
                    SizedBox(width: 16),
                    Expanded(child: lon.build()),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      child: Text('Указать на карте'),
                      style: theme.textButtonGreen,
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
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: ElevatedButton(
          child: Text('СОЗДАТЬ'),
          style: isValid
              ? null
              : ElevatedButton.styleFrom(
                  primary: theme.color.card,
                  onPrimary: theme.color.inactiveBlack,
                ),
          onPressed: () {
            if (formKey.currentState!.validate()) saveSight();
          },
        ),
      ),
    );
  }

  void saveSight() {
    sightRepo.saveSight(Sight(
      name.controller.text,
      geo: GeoPosition(
        double.parse(lat.controller.text),
        double.parse(lon.controller.text),
      ),
      url: sightRepo.absentUrl,
      details: details.controller.text,
      type: '<N/A>',
    ));
  }

  addPhoto() => setState(() => photoUrls.insert(0, Cutesum.randomImageUrl()));
}

class _Photo extends StatefulWidget {
  _Photo(this.url, {required this.onDeleteRequest}) : super(key: ValueKey(url));

  final String url;
  final VoidCallback onDeleteRequest;

  @override
  _PhotoState createState() => _PhotoState();
}

class _PhotoState extends State<_Photo> {
  late final ImageLoader loader;

  @override
  void initState() {
    loader = ImageLoader(widget.url, onProgress: () => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      onDismissed: (direction) => widget.onDeleteRequest(),
      direction: DismissDirection.up,
      key: ValueKey(widget.url),
      child: Container(
        margin: const EdgeInsets.only(left: 16),
        width: 72,
        height: 72,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
            image: loader.provider,
            fit: BoxFit.cover,
          ),
        ),
        child: loader.loaded
            ? Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () => widget.onDeleteRequest(),
                  icon: SvgIcon(
                    'res/figma/Icons/Icon/clear.svg',
                    color: Theme.of(context).color.white,
                  ),
                ),
              )
            : Center(child: CircularProgressIndicator(value: loader.progress)),
      ),
    );
  }
}

@immutable
class _Field {
  _Field({
    required this.title,
    this.autofocus = false,
    this.minLines,
    this.validator,
    required this.next,
    required VoidCallback onValidChange,
  }) : _effectiveValidator = validator ?? nonEmptyValidator {
    _validNotifier = ValueNotifier(isValid);
    _validNotifier.addListener(onValidChange);
    controller.addListener(() => _validNotifier.value = isValid);
  }

  final controller = TextEditingController();
  final focus = FocusNode();
  final String title;
  final bool autofocus;
  final int? minLines;
  final FormFieldValidator<String>? validator;
  final FormFieldValidator<String> _effectiveValidator;
  final _Field? next;
  late final ValueNotifier<bool> _validNotifier;

  void dispose() {
    focus.dispose();
    controller.dispose();
  }

  bool get isValid => _effectiveValidator(controller.text) == null;

  Widget build() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _FieldTitle(title),
        TextFormField(
          autofocus: autofocus,
          controller: controller,
          focusNode: focus,
          onEditingComplete: next != null
              ? () => next!.focus.requestFocus()
              : () => focus.unfocus(),
          textInputAction:
              next != null ? TextInputAction.next : TextInputAction.done,
          validator: _effectiveValidator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          keyboardType:
              validator != null ? TextInputType.number : TextInputType.text,
          minLines: minLines,
          maxLines: minLines == null ? 1 : null,
          decoration: InputDecoration(
            hintText: minLines != null ? 'введите текст' : null,
          ),
        ),
      ],
    );
  }

  static String? nonEmptyValidator(String? s) =>
      (s == null || s.isEmpty) ? 'Введите значение' : null;
}

String? Function(String?) _rangeValidator(double min, double max) =>
    (String? s) {
      late final double d;

      try {
        d = double.parse(s!);
      } catch (e) {
        return 'Нужно число';
      }

      if (d < min) return 'Не меньше $min';
      if (d > max) return 'Не бельше $max';

      return null;
    };

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
        style: theme.text.superSmallInactive,
      ),
    );
  }
}
