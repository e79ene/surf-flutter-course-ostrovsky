import 'package:flutter/material.dart';
import 'package:places/ui/res/my_images.dart';

class ImageLoader {
  ImageLoader(String url, {required VoidCallback onProgress})
      : provider = Uri.base.resolve(url).host.isNotEmpty
            ? NetworkImage(url) as ImageProvider
            : AssetImage(MyImages.error) {
    _stream = provider.resolve(ImageConfiguration());

    _listener = ImageStreamListener(
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
    );

    _stream.addListener(_listener);
  }

  void dispose() {
    _stream.removeListener(_listener);
  }

  final ImageProvider provider;
  late final ImageStream _stream;
  late final ImageStreamListener _listener;

  double? _progress = 0;
  double? get progress => _progress;

  bool _loaded = false;
  bool get loaded => _loaded;
}
