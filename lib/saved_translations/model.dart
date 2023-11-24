class SavedTranslation {
  final String name;
  final String json;
  final String originalText;

  SavedTranslation({
    required this.name,
    required this.json,
    required this.originalText,
  });

  factory SavedTranslation.fromJson(Map<String, dynamic> json) {
    return SavedTranslation(
      name: json['name'],
      json: json['json'],
      originalText: json['originalText'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'json': json,
      'originalText': originalText,
    };
  }
}
