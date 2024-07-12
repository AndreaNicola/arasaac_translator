import 'package:arasaac_translator/arasaac/arasaac_pictogram_image.dart';
import 'package:arasaac_translator/arasaac/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditPictogramDialog extends StatefulWidget {
  final TranslationResponse translationResponse;
  final Function(TranslationResponse translationResponse) onSave;

  const EditPictogramDialog({super.key, required this.translationResponse, required this.onSave});

  @override
  State<StatefulWidget> createState() {
    return _EditPictogramDialogState();
  }
}

class _EditPictogramDialogState extends State<EditPictogramDialog> {
  @override
  void initState() {
    super.initState();
    translationResponse = widget.translationResponse;
    textEditingController.text = translationResponse.text;
  }

  late TranslationResponse translationResponse;
  TextEditingController textEditingController = TextEditingController();

  bool isSelected(int pictogramId) {
    return widget.translationResponse.pictogramId == pictogramId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.editPictogram),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              widget.onSave(translationResponse);
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              controller: textEditingController,
              inputFormatters: [
                TextInputFormatter.withFunction((oldValue, newValue) {
                  return newValue.copyWith(text: newValue.text.toUpperCase());
                })
              ],
              onChanged: (value) {
                setState(() {
                  translationResponse.text = value;
                });
              },
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: AppLocalizations.of(context)!.editText,
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(10),
              shrinkWrap: true,
              itemCount: translationResponse.alternatives.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: isSelected(translationResponse.alternatives[index].pictogramId!) ? Colors.blue : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        translationResponse.pictogramId = translationResponse.alternatives[index].pictogramId;
                      });
                    },
                    child: ArasaacPictogramImage(
                      id: translationResponse.alternatives[index].pictogramId!,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
