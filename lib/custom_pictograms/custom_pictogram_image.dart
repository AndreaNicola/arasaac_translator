import 'package:arasaac_translator/arasaac/arasaac_pictogram_image.dart';
import 'package:arasaac_translator/custom_pictograms/custom_pictogram_repository.dart';
import 'package:flutter/material.dart';

/// A widget that displays a custom Arasaac pictogram image.
///
/// This widget takes a `customPictogramId` parameter to fetch and display the corresponding custom pictogram.
/// The `customPictogramId` parameter is required and represents the id of the custom pictogram.
class CustomPictogramImage extends StatelessWidget {
  /// The id of the custom pictogram.
  final int customPictogramId;

  /// Constructs a `CustomPictogramImage` instance.
  ///
  /// The constructor takes a `customPictogramId` parameter to initialize the `customPictogramId` property.
  const CustomPictogramImage({super.key, required this.customPictogramId});

  /// Builds the widget.
  ///
  /// This method returns a `FutureBuilder` widget that fetches the custom pictogram and displays it.
  /// If the custom pictogram is fetched successfully, it is displayed as an `Image` widget.
  /// If the custom pictogram is not fetched yet, a `CircularProgressIndicator` widget is displayed.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: CustomPictogramRepository.instance.get(customPictogramId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.imageBytes == null) {
            return ArasaacPictogramImage(id: snapshot.data!.arasaacId!);
          } else {
            return Image.memory(
              snapshot.data!.imageBytes!,
              width: 300,
              height: 300,
              fit: BoxFit.fitWidth,
            );
          }
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
