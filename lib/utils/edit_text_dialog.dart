import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditTextDialog extends StatefulWidget {
  final String initialText;
  final Function(String) onSaved;
  final String title;

  const EditTextDialog({super.key, required this.initialText, required this.onSaved, required this.title});

  @override
  State<StatefulWidget> createState() => _EditTextDialogState();
}

class _EditTextDialogState extends State<EditTextDialog> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.initialText;
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: const EdgeInsets.all(20),
      title: Text(widget.title),
      children: [
        // campo di testo per modificare il testo
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
