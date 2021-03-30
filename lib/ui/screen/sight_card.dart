import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/image_loader.dart';

class SightCard extends StatefulWidget {
  final Sight sight;
  final List<Widget> actions;
  final Widget afterTitle;
  final VoidCallback? onTap;

  SightCard(
    this.sight, {
    required this.actions,
    required this.afterTitle,
    this.onTap,
  });

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

    return InkWell(
      onTap: widget.onTap,
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
                    style: theme.accentTextTheme.headline6,
                  ),
                ),
                Positioned(
                  top: 5,
                  right: 8,
                  child: IconTheme(
                    data: theme.accentIconTheme,
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
                color: Theme.of(context).cardColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    widget.sight.name,
                    style: theme.textTheme.headline6,
                  ),
                  widget.afterTitle,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
