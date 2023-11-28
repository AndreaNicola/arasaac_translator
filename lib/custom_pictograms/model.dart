import 'dart:typed_data';

/// Represents a custom pictogram.
///
/// A custom pictogram consists of an optional id, a key, and image bytes.
/// The id is optional because a new pictogram that has not been saved yet does not have an id.
/// The key is a string that uniquely identifies the pictogram.
/// The image bytes represent the image of the pictogram.
class CustomPictogram {
  /// The id of the pictogram. Can be null for a new pictogram.

  /// The key of the pictogram. Must be unique.
  final String key;

  /// The image bytes of the pictogram.
  final Uint8List? imageBytes;

  final int? arasaacId;

  /// Creates a new instance of [CustomPictogram].
  ///
  /// The [id] parameter is the id of the pictogram. It can be null for a new pictogram.
  /// The [key] parameter is the key of the pictogram. It must be unique.
  /// The [imageBytes] parameter are the image bytes of the pictogram.
  CustomPictogram({required this.key, required this.imageBytes, required this.arasaacId});

  /// Converts the pictogram to a map.
  ///
  /// The map contains the id, key, and image bytes of the pictogram.
  /// This can be useful for saving the pictogram to a database.
  Map<String, dynamic> toMap() {
    return {
      'key': key,
      'image': imageBytes,
      'arasaacId': arasaacId,
    };
  }

  /// Returns a string representation of the pictogram.
  ///
  /// The string contains the id, key, and the length of the image bytes of the pictogram.
  @override
  String toString() {
    return 'CustomPictogram{key: $key, image: ${imageBytes?.length ?? 0} bytes, arasaacId: $arasaacId}';
  }
}
