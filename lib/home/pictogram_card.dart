import 'package:arasaac_translator/arasaac/arasaac_pictogram_image.dart';
import 'package:arasaac_translator/custom_pictograms/custom_pictogram_image.dart';
import 'package:flutter/material.dart';

class PictogramCard extends StatelessWidget {
  final String text;
  final int? id;
  final int? customPictogramId;
  final bool error;
  final Function()? onTap;

  const PictogramCard({super.key, required this.text, this.id, required this.error, this.onTap, this.customPictogramId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (id != null && id != 0) Expanded(child: ArasaacPictogramImage(id: id!)),
            if (customPictogramId != null && customPictogramId != 0) Expanded(child: CustomPictogramImage(customPictogramId: customPictogramId!)),
            Text(
              text,
              textAlign: TextAlign.center,
              overflow: TextOverflow.visible,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
