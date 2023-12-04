import 'dart:io';

import 'package:arasaac_translator/arasaac/model.dart';
import 'package:arasaac_translator/custom_pictograms/custom_pictogram_repository.dart';
import 'package:arasaac_translator/utils/arasaac_pictogram_uri.dart';
import 'package:flutter/foundation.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:printing/printing.dart';

class PrintService {
  bool isPrinting = false;
  static final PrintService instance = PrintService._internal();

  late bool _permissionReady;
  late TargetPlatform? _platform;

  PrintService._internal() {
    if (Platform.isAndroid) {
      _platform = TargetPlatform.android;
    } else {
      _platform = TargetPlatform.iOS;
    }
  }

  Future<List<Widget>> _createSentence(List<TranslationResponse> sentence) async {
    var sentenceChildren = <Widget>[];

    for (var word in sentence) {
      sentenceChildren.add(await _createWord(word));
    }

    return sentenceChildren;
  }

  Future<Widget> _createWord(TranslationResponse word) async {
    Image? image;

    if (word.pictogramId != null) {
      final imageUri = buildArasaacPictogramUri(word.pictogramId!);
      final netImage = await networkImage(imageUri);
      image = pw.Image(
        netImage,
        // width: 75,
        // height: 75,
      );
    } else {
      final pictogramKey = word.customPictogramKey ?? "";
      final cp = await CustomPictogramRepository.instance.get(pictogramKey);
      if (cp != null) {
        if (cp.arasaacId != null) {
          final imageUri = buildArasaacPictogramUri(cp.arasaacId!);
          final netImage = await networkImage(imageUri);
          image = pw.Image(
            netImage,
            // width: 75,
            // height: 75,
          );
        } else if (cp.imageBytes != null) {
          image = pw.Image(
            pw.MemoryImage(
              cp.imageBytes!,
            ),
            // width: 75,
            // height: 75,
          );
        }
      }
    }

    return pw.Container(
      child: pw.Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (image != null) image,
          pw.Text(word.text),
        ],
      ),
    );
  }

  void print({required String fileName, required List<List<TranslationResponse>> translationResponses}) async {


    List<Widget> sentencesChildren = [];
    for (var sentence in translationResponses) {
      sentencesChildren.add(pw.GridView(
        childAspectRatio: 1.2,
        crossAxisCount: 6,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        children: await _createSentence(sentence),
      ));
    }

    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Column(
              children: sentencesChildren,
            );
          }),
    );

    final dir = await getApplicationCacheDirectory();
    final file = File('${dir.path}/$fileName.pdf');
    await file.writeAsBytes(await pdf.save());
    await OpenFile.open(file.path);
  }
}
