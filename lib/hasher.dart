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
      final image = copyResize(
        src,
        width: size + 1,
        height: size,
      );
      final arr = BitArray(size * size);
      int normalizedIndex = 0;
      for (int x = 1; x < image.width; x++) {
        for (int y = 0; y < image.height; y++) {
          final pixel = image.getPixel(x, y);
          final compPixel = image.getPixel(x - 1, y);

          arr[normalizedIndex] = pixel.luminanceNormalized >= compPixel.luminanceNormalized;
          normalizedIndex++;
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
