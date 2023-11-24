import 'package:flutter/cupertino.dart';

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

/// A widget that displays an Arasaac pictogram image.
///
/// This widget takes several parameters to customize the displayed image.
/// The `id` parameter is required and represents the id of the pictogram.
/// The `action` parameter represents the verbal tense of the pictogram and can be null.
/// The `plural` parameter indicates whether the pictogram should be plural. It defaults to false.
/// The `noColor` parameter indicates whether the pictogram should be colorless. It defaults to false.
/// The `hairColor` parameter represents the hair color of the pictogram and can be null.
/// The `skinColor` parameter represents the skin color of the pictogram and can be null.
class ArasaacPictogramImage extends StatelessWidget {
  /// The id of the pictogram.
  final num id;

  /// The verbal tense of the pictogram.
  final VerbalTense? action;

  /// Whether the pictogram should be plural.
  final bool plural;

  /// Whether the pictogram should be colorless.
  final bool noColor;

  /// The hair color of the pictogram.
  final HairColor? hairColor;

  /// The skin color of the pictogram.
  final SkinColor? skinColor;

  /// Constructs an `ArasaacPictogramImage` instance.
  ///
  /// The constructor takes several parameters to customize the displayed image.
  /// The `id` parameter is required and represents the id of the pictogram.
  /// The `action` parameter represents the verbal tense of the pictogram and can be null.
  /// The `plural` parameter indicates whether the pictogram should be plural. It defaults to false.
  /// The `noColor` parameter indicates whether the pictogram should be colorless. It defaults to false.
  /// The `hairColor` parameter represents the hair color of the pictogram and can be null.
  /// The `skinColor` parameter represents the skin color of the pictogram and can be null.
  const ArasaacPictogramImage({
    super.key,
    required this.id,
    this.action,
    this.plural = false,
    this.noColor = false,
    this.hairColor,
    this.skinColor,
  });

  /// Builds the URI for the pictogram image.
  ///
  /// The URI is constructed based on the parameters provided to the widget.
  /// The `id` parameter is always included in the URI.
  /// The `action` parameter is included in the URI if it is not null.
  /// The `plural` parameter is included in the URI if it is true.
  /// The `noColor` parameter is included in the URI if it is true.
  /// The `hairColor` parameter is included in the URI if it is not null.
  /// The `skinColor` parameter is included in the URI if it is not null.
  String _buildUri() {
    String uri = "https://static.arasaac.org/pictograms/$id/$id";

    if (action != null) {
      uri = "${uri}_action-${action!.tense}";
    }

    if (plural) {
      uri = "${uri}_plural";
    }

    if (noColor) {
      uri = "${uri}_nocolor";
    }

    if (hairColor != null) {
      uri = "${uri}_hair-${hairColor!.color}";
    }

    if (skinColor != null) {
      uri = "${uri}_skin-${skinColor!.color}";
    }

    uri = "${uri}_300.png";
    return uri;
  }

  /// Builds the widget.
  ///
  /// This method returns an `Image` widget that displays the pictogram image.
  /// The image is fetched from the URI built by the `_buildUri` method.
  @override
  Widget build(BuildContext context) {
    return Image.network(_buildUri());
  }
}
