import 'package:arasaac_translator/custom_pictograms/custom_pictogram_repository.dart';
import 'package:flutter/material.dart';

class CustomPictogramImage extends StatelessWidget {
  final int customPictogramId;

  const CustomPictogramImage({super.key, required this.customPictogramId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: CustomPictogramRepository.instance.get(customPictogramId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Image.memory(
            snapshot.data!.imageBytes,
            width: 300,
            height: 300,
            fit: BoxFit.fitWidth,
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
