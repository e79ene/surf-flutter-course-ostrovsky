import 'package:flutter/material.dart';

Widget imageLoadingProgress(
  BuildContext ctx,
  Widget child,
  ImageChunkEvent? loadingProgress,
) {
  if (loadingProgress == null) {
    return child;
  } else {
    return Center(
      child: CircularProgressIndicator(
        value: loadingProgress.expectedTotalBytes != null
            ? loadingProgress.cumulativeBytesLoaded /
                loadingProgress.expectedTotalBytes!
            : null,
      ),
    );
  }
}
