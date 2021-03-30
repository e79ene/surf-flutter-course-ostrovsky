import 'package:flutter/material.dart';

class ImageLoader {
  ImageLoader(String url, {required VoidCallback onProgress})
      : provider = NetworkImage(url) {
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

  final NetworkImage provider;

  double? _progress = 0;
  double? get progress => _progress;

  bool _loaded = false;
  bool get loaded => _loaded;
}
