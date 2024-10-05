import 'package:bit_array/bit_array.dart';
import 'package:bitcount/bitcount.dart';
import 'package:equatable/equatable.dart';
import 'package:image_hasher_dart/exceptions/hash_incompatibility_exception.dart';

class ImageHash with EquatableMixin {
  /// Array of hash bytes
  final BitArray hashList;

  /// Size of hash square
  final int resolution;

  int get length => (hashList.length / 8).ceil();

  @override
  List<Object> get props => [
        hashList,
        resolution,
      ];

  ImageHash({
    required this.resolution,
    required this.hashList,
  });

  double compareTo(final ImageHash b) {
    if (hashList.length != b.hashList.length) {
      throw const HashIncompatibilityException(
        message: 'Hash length mismatch',
      );
    }
    final copy = hashList.clone();
    copy.xor(b.hashList);
    final iter = copy.asUint32Iterable();

    int unequalCount = 0;
    for (int i in iter) {
      unequalCount += i.bitCount();
    }

    final percentage = unequalCount / hashList.length;
    return 1 - percentage;
  }
}
