import 'package:arasaac_translator/custom_pictograms/custom_pictogram_repository.dart';
import 'package:arasaac_translator/custom_pictograms/edit_custom_pictogram_page.dart';
import 'package:arasaac_translator/custom_pictograms/model.dart';
import 'package:arasaac_translator/home/pictogram_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// A widget that displays a page for managing custom pictograms.
///
/// This widget is a `StatefulWidget` that maintains a list of custom pictograms.
/// The list of custom pictograms is fetched from the `CustomPictogramRepository` when the widget is initialized.
/// The widget provides a user interface for adding and editing custom pictograms.
class CustomPictogramsPage extends StatefulWidget {
  /// Constructs a `CustomPictogramsPage` instance.
  const CustomPictogramsPage({super.key});

  /// Creates the mutable state for this widget.
  @override
  State<StatefulWidget> createState() => _CustomPictogramsPageState();
}

/// The mutable state for a `CustomPictogramsPage` widget.
///
/// This class fetches the list of custom pictograms from the `CustomPictogramRepository` when it is initialized.
/// It provides a user interface for displaying the list of custom pictograms and for navigating to the `EditCustomPictogramPage` widget.
class _CustomPictogramsPageState extends State<CustomPictogramsPage> {
  /// The list of custom pictograms.
  List<CustomPictogram> customPictograms = [];
  static const double _cardSize = 125;

  /// Initializes the state.
  ///
  /// This method fetches the list of custom pictograms from the `CustomPictogramRepository` and updates the state.
  @override
  void initState() {
    super.initState();
    CustomPictogramRepository.instance.list().then((value) {
      setState(() {
        customPictograms = value;
      });
    });
  }

  /// Builds the widget.
  ///
  /// This method returns a `Scaffold` widget that provides a user interface for managing custom pictograms.
  /// The `Scaffold` widget contains a `FloatingActionButton` for navigating to the `EditCustomPictogramPage` widget and a `GridView` for displaying the list of custom pictograms.
  @override
  Widget build(BuildContext context) {
    var cardNumber = MediaQuery.of(context).size.width ~/ _cardSize;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditCustomPictogramPage(
                customPictogram: null,
                onSave: (key, imageBytes, arasaacId) async {
                  await CustomPictogramRepository.instance.insert(CustomPictogram(key: key, imageBytes: imageBytes, arasaacId: arasaacId));
                  var newCustomPictograms = await CustomPictogramRepository.instance.list();
                  setState(() {
                    customPictograms.clear();
                    customPictograms.addAll(newCustomPictograms);
                  });
                },
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.customPictograms)),
      body: customPictograms.isEmpty
          ? Center(
              child: Text(AppLocalizations.of(context)!.noCustomPictograms),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: cardNumber,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditCustomPictogramPage(
                            customPictogram: customPictograms[index],
                            onSave: (key, imageBytes, arasaacId) async {
                              await CustomPictogramRepository.instance.insert(CustomPictogram(key: key, imageBytes: imageBytes, arasaacId: arasaacId));
                              var newCustomPictograms = await CustomPictogramRepository.instance.list();
                              setState(() {
                                customPictograms.clear();
                                customPictograms.addAll(newCustomPictograms);
                              });
                            },
                          ),
                        ),
                      );
                    },
                    child: Stack(
                      fit: StackFit.expand,
                      clipBehavior: Clip.none,
                      children: [
                        PictogramCard(
                          text: customPictograms[index].key,
                          customPictogramKey: customPictograms[index].key,
                        ),
                        Positioned(
                          right: -10,
                          top: -10,
                          child: FloatingActionButton.small(
                            heroTag: 'delete${customPictograms[index].key}',
                            shape: const CircleBorder(),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text(AppLocalizations.of(context)!.confirmCustomPictogramDeleteTitle),
                                    content: Text(AppLocalizations.of(context)!.confirmCustomPictogramDeleteText),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text(AppLocalizations.of(context)!.cancel),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          CustomPictogramRepository.instance.delete(customPictograms[index].key);
                                          setState(() {
                                            customPictograms.removeAt(index);
                                          });
                                        },
                                        child: Text(AppLocalizations.of(context)!.delete),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: const Icon(Icons.delete),
                          ),
                        ),
                      ],
                    ));
              },
              itemCount: customPictograms.length,
            ),
    );
  }
}
