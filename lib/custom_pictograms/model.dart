import 'dart:typed_data';

class CustomPictogram {
  final int? id;
  final String key;
  final Uint8List imageBytes;

  CustomPictogram({required this.id, required this.key, required this.imageBytes});

  // toMap
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'key': key,
      'image': imageBytes,
    };
  }

  //toString
  @override
  String toString() {
    return 'CustomPictogram{id: $id, key: $key, image: ${imageBytes.length} bytes}';
  }
}
