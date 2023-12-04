/// Enum representing the verbal tenses.
///
/// This enum is used to represent the verbal tenses in the context of the `ArasaacPictogramImage` class.
/// It currently supports two tenses: past and future.
/// Each enum value is associated with a string representation of the tense.
enum VerbalTense {
  /// Represents the past tense.
  past("past"),

  /// Represents the future tense.
  future("future");

  /// The string representation of the tense.
  final String tense;

  /// Constructs a `VerbalTense` instance.
  ///
  /// The constructor takes a string that represents the tense.
  const VerbalTense(this.tense);
}

/// Enum representing different hair colors.
///
/// This enum is used to represent different hair colors in the context of the `ArasaacPictogramImage` class.
/// It currently supports seven colors: brown, blonde, red, black, gray, darkGray, and darkBrown.
/// Each enum value is associated with a string representation of the color in hexadecimal format.
enum HairColor {
  /// Represents the color brown.
  brown("A65E26"),

  /// Represents the color blonde.
  blonde("FDD700"),

  /// Represents the color red.
  red("ED4120"),

  /// Represents the color black.
  black("020100"),

  /// Represents the color gray.
  gray("EFEFEF"),

  /// Represents the color dark gray.
  darkGray("AAABAB"),

  /// Represents the color dark brown.
  darkBrown("6A2703");

  /// The string representation of the color in hexadecimal format.
  final String color;

  /// Constructs a `HairColor` instance.
  ///
  /// The constructor takes a string that represents the color in hexadecimal format.
  const HairColor(this.color);
}


/// Enum representing different skin colors.
///
/// This enum is used to represent different skin colors in the context of the `ArasaacPictogramImage` class.
/// It currently supports five colors: white, black, asian, mulatto, and aztec.
/// Each enum value is associated with a string representation of the color in hexadecimal format.
enum SkinColor {
  /// Represents the color white.
  white("F5E5DE"),

  /// Represents the color black.
  black("A65C17"),

  /// Represents the color asian.
  asian("F4ECAD"),

  /// Represents the color mulatto.
  mulatto("E3AB72"),

  /// Represents the color aztec.
  aztec("CF9D7C");

  /// The string representation of the color in hexadecimal format.
  final String color;

  /// Constructs a `SkinColor` instance.
  ///
  /// The constructor takes a string that represents the color in hexadecimal format.
  const SkinColor(this.color);
}

/// Builds the URI for the pictogram image.
///
/// The URI is constructed based on the parameters provided to the widget.
/// The `id` parameter is always included in the URI.
/// The `action` parameter is included in the URI if it is not null.
/// The `plural` parameter is included in the URI if it is true.
/// The `noColor` parameter is included in the URI if it is true.
/// The `hairColor` parameter is included in the URI if it is not null.
/// The `skinColor` parameter is included in the URI if it is not null.
String buildArasaacPictogramUri(int id, {VerbalTense? action, bool plural = false, bool noColor = false, HairColor? hairColor, SkinColor? skinColor}) {
  String uri = "https://static.arasaac.org/pictograms/$id/$id";

  if (action != null) {
    uri = "${uri}_action-${action.tense}";
  }

  if (plural) {
    uri = "${uri}_plural";
  }

  if (noColor) {
    uri = "${uri}_nocolor";
  }

  if (hairColor != null) {
    uri = "${uri}_hair-${hairColor.color}";
  }

  if (skinColor != null) {
    uri = "${uri}_skin-${skinColor.color}";
  }

  uri = "${uri}_300.png";
  return uri;
}