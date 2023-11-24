/// A class that represents a translation response.
///
/// This class is used to represent a translation response in the context of the application.
/// It contains several properties: `text`, `pictogramId`, `customPictogramId`, `error`, and `index`.
/// The `text` property represents the translated text.
/// The `pictogramId` property represents the id of the pictogram associated with the translation.
/// The `customPictogramId` property represents the id of the custom pictogram associated with the translation.
/// The `error` property indicates whether there was an error with the translation.
/// The `index` property represents the index of the translation in a list of translations.
class TranslationResponse {
  /// The translated text.
  String text;

  /// The id of the pictogram associated with the translation.
  final int? pictogramId;

  /// The id of the custom pictogram associated with the translation.
  final int? customPictogramId;

  /// Whether there was an error with the translation.
  final bool error;

  /// The index of the translation in a list of translations.
  final int index;

  /// Constructs a `TranslationResponse` instance.
  ///
  /// The constructor takes several parameters to initialize the properties of the instance.
  /// The `index` and `text` parameters are required.
  /// The `pictogramId` and `customPictogramId` parameters are optional and can be null.
  /// The `error` parameter is optional and defaults to false.
  TranslationResponse({required this.index, required this.text, this.pictogramId, this.customPictogramId, this.error = false});

  /// Constructs a `TranslationResponse` instance from a JSON object.
  ///
  /// The constructor takes a JSON object and initializes the properties of the instance based on the object.
  /// The `text`, `pictogramId`, `customPictogramId`, `error`, and `index` properties are initialized from the corresponding keys in the JSON object.
  TranslationResponse.fromJson(Map<String, dynamic> json)
      : text = json['text'],
        pictogramId = json['pictogramId'],
        customPictogramId = json['customPictogramId'],
        error = json['error'],
        index = json['index'];

  /// Converts the `TranslationResponse` instance to a JSON object.
  ///
  /// The method returns a JSON object that represents the `TranslationResponse` instance.
  /// The `text`, `pictogramId`, `customPictogramId`, `error`, and `index` properties are included in the JSON object.
  Map<String, dynamic> toJson() => {
        'text': text,
        'pictogramId': pictogramId,
        'customPictogramId': customPictogramId,
        'error': error,
        'index': index,
      };
}
