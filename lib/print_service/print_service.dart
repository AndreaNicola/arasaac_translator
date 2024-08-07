import 'dart:io';

import 'package:arasaac_translator/arasaac/model.dart';
import 'package:arasaac_translator/custom_pictograms/custom_pictogram_repository.dart';
import 'package:arasaac_translator/print_service/my_full_page.dart';
import 'package:arasaac_translator/utils/arasaac_pictogram_uri.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';

class PrintService {
  bool isPrinting = false;
  static final PrintService instance = PrintService._internal();

  PrintService._internal();

  Future<Widget> _createWord(TranslationResponse word) async {
    Image? image;

    if (word.pictogramId != null) {
      final imageUri = buildArasaacPictogramUri(word.pictogramId!);
      final netImage = await networkImage(imageUri);
      image = pw.Image(
        netImage,
        width: 100,
        height: 100,
        fit: pw.BoxFit.cover,
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
            width: 100,
            height: 100,
            fit: pw.BoxFit.cover,
          );
        } else if (cp.imageBytes != null) {
          image = pw.Image(
            height: 100,
            width: 100,
            fit: pw.BoxFit.cover,
            pw.MemoryImage(
              cp.imageBytes!,
            ),
          );
        }
      }
    }

    return pw.Container(
      width: 100,
      height: 100,
      child: pw.Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (image != null) image,
          pw.Expanded(
            child: pw.Text(
              textAlign: pw.TextAlign.center,
              word.text,
              overflow: pw.TextOverflow.visible,
            ),
          ),
        ],
      ),
    );
  }

  void print({required String fileName, required List<List<TranslationResponse>> translationResponses}) async {
    final fullPages = await _createFullPages(maxRows: 6, maxColumns: 5, translationResponses: translationResponses);
    final pages = fullPages.map((e) => _convertMyFullPage(e)).toList();

    final pdf = pw.Document();
    for (var element in pages) {
      pdf.addPage(element);
    }

    final dir = await getApplicationCacheDirectory();
    final file = File('${dir.path}/$fileName.pdf');
    await file.writeAsBytes(await pdf.save());
    await OpenFilex.open(file.path);
  }

  Future<List<MyFullPage<Widget>>> _createFullPages({
    required int maxRows,
    required int maxColumns,
    required List<List<TranslationResponse>> translationResponses,
  }) async {
    var fullPages = <MyFullPage<Widget>>[MyFullPage(maxRows: maxRows, maxColumns: maxColumns)];
    for (var sentence in translationResponses) {
      for (var word in sentence) {
        final w = await _createWord(word);
        try {
          fullPages.last.add(w);
        } catch (e) {
          fullPages.add(MyFullPage(maxRows: maxRows, maxColumns: maxColumns));
          fullPages.last.add(w);
        }
      }

      try {
        fullPages.last.newLine();
      } catch (e) {
        fullPages.add(MyFullPage(maxRows: maxRows, maxColumns: maxColumns));
      }
    }

    return fullPages;
  }

  pw.Page _convertMyFullPage(MyFullPage<Widget> fullPage) {
    final pageElements = fullPage.page.map((e) {
      return e ?? pw.Container(width: 0, height: 0);
    }).toList();
    return pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.GridView(
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          crossAxisCount: fullPage.maxColumns,
          children: pageElements,
        );
      },
    );
  }
}
