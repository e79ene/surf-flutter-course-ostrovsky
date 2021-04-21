import 'package:flutter/material.dart';
import 'package:places/data/model/category.dart';
import 'package:places/ui/res/my_icons.dart';
import 'package:places/ui/res/text_kit.dart';
import 'package:places/ui/res/themes.dart';
import 'package:places/ui/screen/widget/my_app_bar.dart';
import 'package:places/ui/svg_icon.dart';

class CategoryScreen extends StatefulWidget {
  final Category? initialCategory;

  const CategoryScreen(
    this.initialCategory, {
    Key? key,
  }) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  Category? category;

  @override
  void initState() {
    super.initState();
    category = widget.initialCategory;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Категория'),
      body: ListView(
        children: [
          for (final c in Category.byId.values) buildCategory(c, context),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: ElevatedButton(
          onPressed: category == null
              ? null
              : () => Navigator.maybePop<Category>(context, category),
          child: Text('СОХРАНИТЬ'),
        ),
      ),
    );
  }

  buildCategory(Category c, BuildContext context) {
    final theme = Theme.of(context);
    final selected = c == category;

    return InkWell(
      onTap: () => setState(() => category = selected ? null : c),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SizedBox(
              height: 48,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    c.name,
                    style: theme.text.text.withColor(theme.color.title),
                  ),
                  if (selected) SvgIcon(MyIcons.Tick, color: theme.color.green),
                ],
              ),
            ),
            Container(
              height: 1,
              color: theme.color.inactiveBlack,
            )
          ],
        ),
      ),
    );
  }
}
