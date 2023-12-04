import 'package:arasaac_translator/arasaac/model.dart';
import 'package:arasaac_translator/custom_pictograms/custom_pictogram_repository.dart';
import 'package:arasaac_translator/custom_pictograms/model.dart';
import 'package:arasaac_translator/home/pictogram_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ConfirmCustomPictogramSave extends StatefulWidget {
  final Function onConfirm;
  final Function onCancel;
  final TranslationResponse translationResponse;

  const ConfirmCustomPictogramSave({super.key, required this.onConfirm, required this.onCancel, required this.translationResponse});

  @override
  State<StatefulWidget> createState() {
    return _ConfirmCustomPictogramSaveState();
  }
}

class _ConfirmCustomPictogramSaveState extends State<ConfirmCustomPictogramSave> {
  CustomPictogram? oldCustomPictogram;

  @override
  void initState() {
    super.initState();
    CustomPictogramRepository.instance.get(widget.translationResponse.text).then((value) => setState(() {
          oldCustomPictogram = value;
        }));
  }

  @override
  Widget build(BuildContext context) {
    if (oldCustomPictogram == null) {
      return AlertDialog(
        title: Text(AppLocalizations.of(context)!.confirmCustomPictogramSaveTitle),
        content: Text(AppLocalizations.of(context)!.confirmCustomPictogramSaveText),
        actions: [
          TextButton(
            onPressed: () {
              widget.onCancel();
            },
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          TextButton(
            onPressed: () {
              widget.onConfirm();
            },
            child: Text(AppLocalizations.of(context)!.save),
          ),
        ],
      );
    } else {
      return AlertDialog(
        title: Text(AppLocalizations.of(context)!.confirmCustomPictogramSaveTitle),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(AppLocalizations.of(context)!.confirmCustomPictogramSaveText),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              child: Text(AppLocalizations.of(context)!.confirmCustomPictogramSaveOverwrite),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 25),
              width: 150,
              height: 150,
              child: PictogramCard(
                text: oldCustomPictogram!.key,
                customPictogramKey: oldCustomPictogram!.key,
                onTap: null,
                onLongPress: null,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              widget.onCancel();
            },
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          TextButton(
            onPressed: () {
              widget.onConfirm();
            },
            child: Text(AppLocalizations.of(context)!.save),
          ),
        ],
      );
    }
  }
}
