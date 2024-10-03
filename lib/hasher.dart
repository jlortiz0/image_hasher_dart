import 'dart:async';

import 'package:image/image.dart';

import 'models/image_hash.dart';
import 'models/hash_pixel.dart';

class Hasher {
  final int size;
  final int depth;

  final int _depthDivider;

  const Hasher({
    this.size = 32,
    this.depth = 8,
  }) : _depthDivider = 256 ~/ depth;

  HashPixel _colorToHashPixel(Pixel pixel) => HashPixel(
        r: pixel.r ~/ _depthDivider,
        g: pixel.g ~/ _depthDivider,
        b: pixel.b ~/ _depthDivider,
        a: pixel.a ~/ _depthDivider,
      );

  //FIXME: Its not async but has future return type
  FutureOr<ImageHash> getImageHash(Image src) {
    final future = Future(() {
      final image = copyResize(
        src,
        width: size,
        height: size,
      );
      final hash = ImageHash(
        depth: depth,
        resolution: size,
      );

      int normalizedIndex = 0;
      for (int x = 0; x < image.width; x++) {
        for (int y = 0; y < image.height; y++) {
          final pixel = image.getPixel(x, y);

          final hashPixel = _colorToHashPixel(pixel);
          hash[normalizedIndex] = hashPixel;
          normalizedIndex++;
        }
      }
      return hash;
    });

    return future;
  }
}
