import 'package:arasaac_translator/utils/arasaac_pictogram_uri.dart';
import 'package:flutter/cupertino.dart';



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
  final int id;

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



  /// Builds the widget.
  ///
  /// This method returns an `Image` widget that displays the pictogram image.
  /// The image is fetched from the URI built by the `_buildUri` method.
  @override
  Widget build(BuildContext context) {
    return Image.network(buildArasaacPictogramUri(id, action: action, plural: plural, noColor: noColor, hairColor: hairColor, skinColor: skinColor));
  }
}
