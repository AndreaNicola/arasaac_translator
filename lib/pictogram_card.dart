import 'package:arasaac_translator/pictogram.dart';
import 'package:flutter/material.dart';

class PictogramCard extends StatelessWidget {
  final String text;
  final num id;
  final bool error;
  final Function()? onTap;

  const PictogramCard({super.key, required this.text, required this.id, required this.error, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (id != 0) Expanded(child: Pictogram(id: id)),
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
