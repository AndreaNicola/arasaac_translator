import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// `EditTextDialog` is a StatefulWidget that displays a dialog for editing text.
///
/// It takes three parameters in its constructor:
/// - a `String` [initialText] which is the initial text displayed in the dialog,
/// - a `Function(String)` [onSaved] which is the function called when the save button is pressed,
/// - a `String` [title] which is the title of the dialog.
///
/// The state for this widget is managed by `_EditTextDialogState`.
class EditTextDialog extends StatefulWidget {
  /// Creates an `EditTextDialog` widget.
  ///
  /// The [initialText], [onSaved] and [title] must not be null.
  const EditTextDialog({super.key, required this.initialText, required this.onSaved, required this.title});

  /// This is the initial text displayed in the dialog.
  final String initialText;

  /// This is the function that is called when the save button is pressed.
  ///
  /// It takes a `String` parameter which is the text entered by the user.
  final Function(String) onSaved;

  /// This is the title of the dialog.
  final String title;

  /// Creates the mutable state for this widget at a given location in the tree.
  @override
  State<StatefulWidget> createState() => _EditTextDialogState();
}

/// `_EditTextDialogState` is the state for `EditTextDialog`.
///
/// It manages a `TextEditingController` and handles the user interaction with the dialog.
class _EditTextDialogState extends State<EditTextDialog> {
  /// A `TextEditingController` that controls the text being edited.
  final TextEditingController _controller = TextEditingController();

  /// Called when this object is inserted into the tree.
  ///
  /// It sets the initial text of the `_controller` to the `initialText` provided by the `EditTextDialog` widget.
  @override
  void initState() {
    super.initState();
    _controller.text = widget.initialText;
  }

  /// Describes the part of the user interface represented by this widget.
  ///
  /// It returns a `SimpleDialog` widget that contains a `TextField` for editing text and two buttons for canceling and saving.
  /// The `TextField` is controlled by the `_controller` and automatically converts the input to uppercase.
  /// The cancel button dismisses the dialog without saving.
  /// The save button calls the `onSaved` function provided by the `EditTextDialog` widget with the current text of the `_controller` and then dismisses the dialog.
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: const EdgeInsets.all(20),
      title: Text(widget.title),
      children: [
        // Text field for editing text
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: TextField(
            controller: _controller,
            onChanged: (String value) {
              _controller.text = _controller.text.toUpperCase();
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(AppLocalizations.of(context)!.cancel)),
            ElevatedButton(
                onPressed: () {
                  widget.onSaved(_controller.text);
                  Navigator.pop(context);
                },
                child: Text(AppLocalizations.of(context)!.save)),
          ],
        )
      ],
    );
  }
}
