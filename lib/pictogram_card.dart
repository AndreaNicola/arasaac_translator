import 'package:arasaac_translator/pictogram.dart';
import 'package:flutter/material.dart';

class PictogramCard extends StatelessWidget {
  final String text;
  final num? id;
  final bool error;

  const PictogramCard({super.key, required this.id, required this.text, this.error = false});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (id != null && id != 0) Expanded(child: Pictogram(id: id!)),
          Text(
            text,
            overflow: TextOverflow.visible,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
