import 'package:arasaac_translator/arasaac/arasaac_pictogram_image.dart';
import 'package:arasaac_translator/custom_pictograms/custom_pictogram_image.dart';
import 'package:flutter/material.dart';

/// Represents a card displaying a pictogram.
///
/// This is a [StatelessWidget] that displays a pictogram and its associated text.
/// The pictogram can be either an Arasaac pictogram or a custom pictogram.
/// The pictogram is identified by its id, which is passed to the constructor.
/// If the id is null or 0, no pictogram is displayed.
/// The text is displayed below the pictogram.
/// The card also has an optional onTap callback, which is called when the card is tapped.
class PictogramCard extends StatelessWidget {
  /// The text to be displayed below the pictogram.
  final String text;

  /// The id of the Arasaac pictogram to be displayed. Can be null or 0, in which case no pictogram is displayed.
  final int? arasaacId;

  /// The id of the custom pictogram to be displayed. Can be null or 0, in which case no pictogram is displayed.
  final String? customPictogramKey;

  /// Indicates whether an error occurred.
  final bool error;

  /// The callback to be called when the card is tapped. Can be null, in which case nothing happens when the card is tapped.
  final Function()? onTap;

  final Function()? onLongPress;

  /// Creates an instance of [PictogramCard].
  ///
  /// The [text] parameter is the text to be displayed below the pictogram.
  /// The [id] parameter is the id of the Arasaac pictogram to be displayed.
  /// The [customPictogramId] parameter is the id of the custom pictogram to be displayed.
  /// The [error] parameter indicates whether an error occurred.
  /// The [onTap] parameter is the callback to be called when the card is tapped.
  const PictogramCard({super.key, required this.text, this.arasaacId, required this.error, this.onTap, this.onLongPress, this.customPictogramKey});

  /// Builds the widget.
  ///
  /// This method returns a [GestureDetector] containing a [Card] with a [Column].
  /// The [Column] contains an [ArasaacPictogramImage] or a [CustomPictogramImage] (if the respective id is not null or 0),
  /// and a [Text] with the text.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (arasaacId != null && arasaacId != 0) Expanded(child: ArasaacPictogramImage(id: arasaacId!)),
            if (customPictogramKey != null && customPictogramKey!.isNotEmpty) Expanded(child: CustomPictogramImage(customPictogramKey: customPictogramKey!)),
            Text(
              text,
              textAlign: TextAlign.center,
              overflow: TextOverflow.visible,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
