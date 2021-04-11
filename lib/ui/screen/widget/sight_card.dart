import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/image_loader.dart';
import 'package:places/ui/screen/sight_details_screen.dart';
import 'package:places/ui/res/themes.dart';

class SightCard extends StatefulWidget {
  final Sight sight;
  final List<Widget> actions;
  final Widget afterTitle;

  SightCard(
    this.sight, {
    Key? key,
    required this.actions,
    required this.afterTitle,
  }) : super(key: key);

  @override
  _SightCardState createState() => _SightCardState();
}

class _SightCardState extends State<SightCard> {
  late final ImageLoader loader;

  @override
  void initState() {
    loader = ImageLoader(widget.sight.url, onProgress: () => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      child: InkWell(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => SightDetailsScreen(widget.sight)),
        ),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Ink(
                height: 96,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  image: DecorationImage(
                  image: loader.provider,
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(children: [
                if (!loader.loaded)
                  Center(
                      child: CircularProgressIndicator(value: loader.progress)),
                  Positioned(
                    top: 16,
                    left: 16,
                    child: Text(
                      widget.sight.type,
                      style: theme.text.smallBold,
                    ),
                  ),
                  Positioned(
                    top: 5,
                    right: 8,
                    child: IconTheme(
                      data: IconThemeData(
                        color: theme.color.white,
                      ),
                      child: Row(children: widget.actions),
                    ),
                  ),
                ]),
              ),
              Ink(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(16)),
                  color: theme.color.card,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      widget.sight.name,
                      style: theme.text.text,
                    ),
                    widget.afterTitle,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
