import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/global_theme.dart';
import 'package:places/ui/image_loading_progress.dart';

class SightCard extends StatelessWidget {
  final Sight sight;
  final List<Widget> actions;
  final Widget afterTitle;

  SightCard(
    this.sight, {
    required this.actions,
    required this.afterTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 198,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: OverflowBox(
          maxHeight: double.infinity,
          alignment: Alignment.topCenter,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(children: [
                Image.network(
                  sight.url,
                  height: 96,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  loadingBuilder: imageLoadingProgress,
                ),
                Positioned(
                  top: 16,
                  left: 16,
                  child: Text(
                    sight.type,
                    style: sightTypeStyle,
                  ),
                ),
                Positioned(
                  top: 5,
                  right: 8,
                  child: Row(children: actions),
                ),
              ]),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      sight.name,
                      style: sightNameStyle,
                    ),
                    afterTitle,
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
