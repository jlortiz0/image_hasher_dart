import 'package:bit_array/bit_array.dart';
import 'package:image_hasher_dart/image_hasher.dart';
import 'package:test/test.dart';

void main() {
  test(
    'Hash.compareTo correctly calculates similarity',
    () {
      const resolution = 4;
      // hydrate hashes with identical data
      final arr = BitArray(resolution * resolution)..setAll();
      final hashA = ImageHash(resolution: resolution, hashList: arr);
      final hashB = ImageHash(resolution: resolution, hashList: arr.clone());

      // hydrate hashes with difference at last position
      hashB.hashList[15] = false;

      final result = hashA.compareTo(hashB);

      // ye im lazy as fuck
      expect(result, lessThan(1));
      expect(result, greaterThan(0.9));
    },
  );
}
