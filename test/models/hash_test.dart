import 'package:bit_array/bit_array.dart';
import 'package:image_hasher_dart/models/image_hash.dart';
import 'package:test/test.dart';

void main() {
  test('hashes with same const hashPixels are equal', () {
    final arr = BitArray(1);
    final a = ImageHash(resolution: 1, hashList: arr);
    final b = ImageHash(resolution: 1, hashList: arr);

    expect(a, equals(b));
  });

  test('hashes with same hashPixels are equal', () {
    final arr = BitArray(1)..setAll();
    final arr2 = BitArray(1)..setAll();
    final a = ImageHash(resolution: 1, hashList: arr);
    final b = ImageHash(resolution: 1, hashList: arr2);

    expect(a, equals(b));
  });

  test('hashes with different hash arrays are not equal', () {
    final arr = BitArray(1)..setAll();
    final arr2 = BitArray(1);
    final a = ImageHash(resolution: 1, hashList: arr);
    final b = ImageHash(resolution: 1, hashList: arr2);

    expect(a, isNot(equals(b)));
  });

  test('hashes with different resolutions are not equal', () {
    final arr = BitArray(1);
    final arr2 = BitArray(4);
    final a = ImageHash(resolution: 1, hashList: arr);
    final b = ImageHash(resolution: 2, hashList: arr2);

    expect(a, isNot(equals(b)));
  });
}
