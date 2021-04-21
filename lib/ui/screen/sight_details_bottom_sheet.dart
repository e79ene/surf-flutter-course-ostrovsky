import 'package:flutter/material.dart';
import 'package:places/data/model/place.dart';
import 'package:places/ui/res/my_icons.dart';
import 'package:places/ui/res/themes.dart';
import 'package:places/ui/screen/widget/sight_details_view.dart';
import 'package:places/ui/svg_icon.dart';

class SightDetailsBottomSheet extends StatelessWidget {
  final Place _sight;

  SightDetailsBottomSheet(this._sight);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      height: MediaQuery.of(context).size.height - 64,
      child: Stack(
        children: [
          SightDetailsView(_sight),
          Container(
            color: Colors.transparent,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 12),
                Container(
                  height: 4,
                  width: 40,
                  decoration: BoxDecoration(
                    color: theme.color.white,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(right: 16),
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    iconSize: 40,
                    padding: EdgeInsets.zero,
                    icon: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: theme.color.background,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: SvgIcon(
                        MyIcons.Close,
                        color: theme.color.title,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
