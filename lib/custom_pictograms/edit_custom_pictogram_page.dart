import 'dart:typed_data';

import 'package:arasaac_translator/custom_pictograms/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';

class EditCustomPictogramPage extends StatefulWidget {
  const EditCustomPictogramPage({super.key, required this.customPictogram, required this.onSave});

  final CustomPictogram? customPictogram;
  final Function(int? id, String key, Uint8List imageBytes) onSave;

  @override
  State<StatefulWidget> createState() => _EditCustomPictogramPageState();
}

class _EditCustomPictogramPageState extends State<EditCustomPictogramPage> {
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _keyController = TextEditingController();
  Uint8List? _imageBytes;

  @override
  void initState() {
    super.initState();
    if (widget.customPictogram != null) {
      _keyController.text = widget.customPictogram!.key;
      _imageBytes = widget.customPictogram!.imageBytes;
    }
  }

  void _pickImage(ImageSource imageSource) {
    _picker.pickImage(source: imageSource, maxWidth: 300, maxHeight: 300, imageQuality: 95, preferredCameraDevice: CameraDevice.rear).then((value) {
      if (value != null) {
        value.readAsBytes().then((value) => setState(() => _imageBytes = value));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          widget.onSave(widget.customPictogram?.id, _keyController.text, _imageBytes!);
          Navigator.pop(context);
        },
        child: const Icon(Icons.save),
      ),
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.newCustomPictogram)),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: TextField(
              controller: _keyController,
              onChanged: (value) {
                _keyController.text = value.toUpperCase();
              },
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.newCustomPictogramKey,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                    onPressed: () {
                      _pickImage(ImageSource.camera);
                    },
                    icon: const Icon(Icons.camera_alt),
                    label: const Text("camera")),
                ElevatedButton.icon(
                    onPressed: () {
                      _pickImage(ImageSource.gallery);
                    },
                    icon: const Icon(Icons.folder_open),
                    label: const Text("gallery")),
              ],
            ),
          ),
          if (_imageBytes != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32),
              child: Image.memory(
                _imageBytes!,
                height: 300,
                width: 300,
              ),
            ),
        ],
      ),
    );
  }
}
