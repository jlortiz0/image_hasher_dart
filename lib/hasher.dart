import 'dart:async';

import 'package:bit_array/bit_array.dart';
import 'package:image/image.dart';

import 'models/image_hash.dart';

class Hasher {
  final int size;

  const Hasher({
    this.size = 32
  });

  //FIXME: Its not async but has future return type
  FutureOr<ImageHash> getImageHash(Image src) {
    final future = Future(() {
      final image = grayscale(copyResize(
        src,
        width: size + 1,
        height: size,
        interpolation: Interpolation.cubic
      ));
      final arr = BitArray(size * size);
      int normalizedIndex = 0;
      for (int y = 0; y < image.height; y++) {
        var prev = image.getPixel(0, y);
        for (int x = 1; x < image.width; x++) {
          final pixel = image.getPixel(x, y);

          arr[normalizedIndex] = pixel.r < prev.r;
          normalizedIndex++;
          prev = pixel;
        }
      }

      return ImageHash(
        resolution: size,
        hashList: arr
      );
    });

    return future;
  }
}
