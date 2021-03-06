import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:lorem_cutesum/lorem_cutesum.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/model/category.dart';
import 'package:places/data/model/geo_position.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/repository/network_exception.dart';
import 'package:places/ui/image_loader.dart';
import 'package:places/ui/res/my_icons.dart';
import 'package:places/ui/res/text_kit.dart';
import 'package:places/ui/res/themes.dart';
import 'package:places/ui/screen/category_screen.dart';
import 'package:places/ui/screen/sight_details_bottom_sheet.dart';
import 'package:places/ui/screen/widget/my_app_bar.dart';
import 'package:places/ui/svg_icon.dart';
import 'package:provider/provider.dart';

class AddSightScreen extends StatefulWidget {
  @override
  _AddSightScreenState createState() => _AddSightScreenState();
}

class _AddSightScreenState extends State<AddSightScreen> {
  late final _Field name, lat, lng, details;
  late final List<_Field> _fields;
  final formKey = GlobalKey<FormState>();
  final photoUrls = <String>[];
  Category? category;
  Future<Place>? addingPlace;

  _AddSightScreenState() {
    details = _Field(
      title: 'описание',
      onValidChange: () => setState(() {}),
      minLines: 3,
      next: null,
    );

    lng = _Field(
      title: 'долгота',
      onValidChange: () => setState(() {}),
      validator: _rangeValidator(-180, 360),
      next: details,
    );

    lat = _Field(
      title: 'широта',
      onValidChange: () => setState(() {}),
      validator: _rangeValidator(-90, 90),
      next: lng,
    );

    name = _Field(
      title: 'название',
      onValidChange: () => setState(() {}),
      autofocus: true,
      next: lat,
    );

    _fields = [name, lat, lng, details];
  }

  @override
  void dispose() {
    for (final field in _fields) field.dispose();

    super.dispose();
  }

  bool get isValid =>
      _fields.every((field) => field.isValid) &&
      photoUrls.length > 0 &&
      category != null;

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
                SizedBox(
                  height: 96,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: photoUrls.length + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) return buildAddPhotoButton(theme);

                      final url = photoUrls[index - 1];
                      return _Photo(
                        url,
                        onDeleteRequest: () =>
                            setState(() => photoUrls.remove(url)),
                      );
                    },
                  ),
                ),
                _FieldTitle('категория'),
                TextButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        category == null ? 'Не выбрано' : category!.name,
                        style:
                            theme.text.text.withColor(theme.color.secondary2),
                      ),
                      SvgIcon(MyIcons.View),
                    ],
                  ),
                  onPressed: () async {
                    final newCategory = await Navigator.push<Category?>(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CategoryScreen(category),
                      ),
                    );
                    setState(() => category = newCategory);
                  },
                ),
                name.build(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: lat.build()),
                    SizedBox(width: 16),
                    Expanded(child: lng.build()),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      child: Text('Указать на карте'),
                      style: theme.textButtonGreen,
                      onPressed: () {
                        lat.controller.value = TextEditingValue(
                            text: GeoPositions.moscow.lat.toString());
                        lng.controller.value = TextEditingValue(
                            text: GeoPositions.moscow.lng.toString());
                      },
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
            if (formKey.currentState!.validate() && isValid) savePlace();
          },
        ),
      ),
    );
  }

  Widget buildAddPhotoButton(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: InkWell(
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
            size: 43,
            color: theme.color.green,
          ),
        ),
      ),
    );
  }

  void savePlace() async {
    final draft = Place.draft(
      name: name.controller.text,
      geo: GeoPosition(
        double.parse(lat.controller.text),
        double.parse(lng.controller.text),
      ),
      urls: photoUrls,
      description: details.controller.text,
      category: category!,
    );

    setState(
      () => {addingPlace = context.read<PlaceInteractor>().addNewPlace(draft)},
    );

    try {
      final newPlace = await addingPlace!;
      if (!mounted) return;

      await SightDetailsBottomSheet.show(context, newPlace, deleteOption: true);
      if (!mounted) return;

      Navigator.pop(context);
    } on NetworkException {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Ошибка'),
          content: Text('Что то пошло не так. Попробуйте позже.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.maybePop(context),
              child: Text('Закрыть'),
            ),
          ],
        ),
      );
    }
  }

  addPhoto() async {
    final String? url = await showDialog<String>(
      context: context,
      builder: (context) => AddPhotoDialog(),
    );

    if (url != null) setState(() => photoUrls.insert(0, url));
  }
}

class AddPhotoDialog extends StatelessWidget {
  const AddPhotoDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      alignment: Alignment.bottomCenter,
      child: Material(
        color: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Ink(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: theme.color.background,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  buildItem(context, 'Камера', MyIcons.Camera),
                  buildSeparator(theme),
                  buildItem(context, 'Фотография', MyIcons.Photo),
                  buildSeparator(theme),
                  buildItem(context, 'Файл', MyIcons.Fail),
                ],
              ),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => Navigator.maybePop(context),
              style: ElevatedButton.styleFrom(
                primary: theme.color.background,
                onPrimary: theme.color.green,
                minimumSize: Size.fromHeight(56),
              ),
              child: Text('ОТМЕНА'),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSeparator(ThemeData theme) {
    return Container(
      height: 1,
      margin: EdgeInsets.symmetric(horizontal: 12),
      color: theme.color.inactiveBlack,
    );
  }

  Widget buildItem(BuildContext context, String label, String assetName) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: () => Navigator.of(context).pop<String>(Cutesum.randomImageUrl()),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        child: Row(
          children: [
            SvgIcon(assetName, color: theme.color.foreground),
            SizedBox(width: 14),
            Text(label, style: theme.text.text),
          ],
        ),
      ),
    );
  }
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
    super.initState();
    loader = ImageLoader(widget.url, onProgress: () => setState(() {}));
  }

  @override
  void dispose() {
    loader.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: Dismissible(
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
                      MyIcons.clear,
                      color: Theme.of(context).color.white,
                    ),
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(value: loader.progress)),
        ),
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
