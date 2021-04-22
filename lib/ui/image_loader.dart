import 'package:flutter/material.dart';
import 'package:places/ui/res/my_images.dart';

class ImageLoader {
  ImageLoader(String url, {required VoidCallback onProgress})
      : provider = Uri.base.resolve(url).host.isNotEmpty
            ? NetworkImage(url) as ImageProvider
            : AssetImage(MyImages.error) {
    provider.resolve(ImageConfiguration()).addListener(
          ImageStreamListener(
            (_, __) {
              _loaded = true;
              onProgress();
            },
            onChunk: (chunk) {
              _progress = chunk.expectedTotalBytes != null
                  ? chunk.cumulativeBytesLoaded / chunk.expectedTotalBytes!
                  : null;
              onProgress();
            },
          ),
        );
  }

  final ImageProvider provider;

  double? _progress = 0;
  double? get progress => _progress;

  bool _loaded = false;
  bool get loaded => _loaded;
}
