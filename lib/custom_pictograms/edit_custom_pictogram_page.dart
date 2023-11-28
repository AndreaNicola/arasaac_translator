import 'dart:typed_data';

import 'package:arasaac_translator/custom_pictograms/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';

/// Represents a page for editing custom pictograms.
///
/// This is a [StatefulWidget] that allows the user to edit a custom pictogram.
/// The pictogram to be edited and a callback function to be called upon saving
/// are passed to the constructor.
class EditCustomPictogramPage extends StatefulWidget {
  /// Creates an instance of [EditCustomPictogramPage].
  ///
  /// The [customPictogram] parameter is the pictogram to be edited. It can be null,
  /// in which case a new pictogram is being created.
  ///
  /// The [onSave] parameter is a callback function that is called when the user
  /// saves the pictogram. It receives the id of the pictogram (which can be null
  /// for a new pictogram), the key of the pictogram, and the image bytes of the pictogram.
  const EditCustomPictogramPage({super.key, required this.customPictogram, required this.onSave});

  /// The pictogram to be edited. Can be null for a new pictogram.
  final CustomPictogram? customPictogram;

  /// The callback function to be called when the user saves the pictogram.
  final Function(String key, Uint8List? imageBytes, int? arasaacId ) onSave;

  /// Creates the mutable state for this widget at a given location in the tree.
  @override
  State<StatefulWidget> createState() => _EditCustomPictogramPageState();
}

/// The state for [EditCustomPictogramPage].
///
/// This class holds the mutable parts of the widget, which can change over the
/// lifetime of the widget. In this case, it includes an [ImagePicker] for
/// picking images, a [TextEditingController] for controlling the text field,
/// and a byte array for the image data.
class _EditCustomPictogramPageState extends State<EditCustomPictogramPage> {
  /// An [ImagePicker] for picking images.
  final ImagePicker _picker = ImagePicker();

  /// A [TextEditingController] for controlling the text field.
  final TextEditingController _keyController = TextEditingController();

  /// A byte array for the image data.
  Uint8List? _imageBytes;

  int? _arasaacId;

  /// Initializes the state.
  ///
  /// If the widget's [CustomPictogram] is not null, it initializes the text
  /// controller's text and the image bytes with the pictogram's key and image
  /// bytes, respectively.
  @override
  void initState() {
    super.initState();
    if (widget.customPictogram != null) {
      _keyController.text = widget.customPictogram!.key;
      _imageBytes = widget.customPictogram!.imageBytes;
      _arasaacId = widget.customPictogram!.arasaacId;
    }
  }

  /// Picks an image.
  ///
  /// This method picks an image from the specified [ImageSource], reads it as
  /// bytes, and updates the state with the image bytes.
  void _pickImage(ImageSource imageSource) {
    _picker.pickImage(source: imageSource, maxWidth: 300, maxHeight: 300, imageQuality: 95, preferredCameraDevice: CameraDevice.rear).then((value) {
      if (value != null) {
        value.readAsBytes().then((value) => setState(() => _imageBytes = value));
      }
    });
  }

  /// Builds the widget.
  ///
  /// This method returns a [Scaffold] containing a [FloatingActionButton] for
  /// saving the pictogram, an [AppBar] with a title, and a [ListView] with a
  /// text field for the pictogram key, buttons for picking an image, and the
  /// picked image.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          widget.onSave(_keyController.text, _imageBytes, _arasaacId);
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