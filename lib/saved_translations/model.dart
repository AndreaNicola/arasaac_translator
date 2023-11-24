/// Represents a saved translation.
///
/// A saved translation consists of a name, a JSON string, and the original text.
/// The name is a string that identifies the translation.
/// The JSON string is a stringified JSON object that represents the translation.
/// The original text is the text that was translated.
class SavedTranslation {
  /// The name of the translation.
  final String name;

  /// The JSON string of the translation.
  final String json;

  /// The original text that was translated.
  final String originalText;

  /// Creates a new instance of [SavedTranslation].
  ///
  /// The [name] parameter is the name of the translation.
  /// The [json] parameter is the JSON string of the translation.
  /// The [originalText] parameter is the original text that was translated.
  SavedTranslation({
    required this.name,
    required this.json,
    required this.originalText,
  });

  /// Creates a new instance of [SavedTranslation] from a map.
  ///
  /// The map must contain the name, JSON string, and original text of the translation.
  /// This can be useful for creating a [SavedTranslation] from a JSON object.
  factory SavedTranslation.fromJson(Map<String, dynamic> json) {
    return SavedTranslation(
      name: json['name'],
      json: json['json'],
      originalText: json['originalText'],
    );
  }

  /// Converts the [SavedTranslation] to a map.
  ///
  /// The map contains the name, JSON string, and original text of the translation.
  /// This can be useful for saving the [SavedTranslation] to a database or converting it to a JSON object.
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'json': json,
      'originalText': originalText,
    };
  }
}
