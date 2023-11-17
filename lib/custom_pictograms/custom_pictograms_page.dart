import 'package:arasaac_translator/custom_pictograms/model.dart';
import 'package:arasaac_translator/custom_pictograms/edit_custom_pictogram_page.dart';
import 'package:arasaac_translator/custom_pictograms/repository.dart';
import 'package:arasaac_translator/home/pictogram_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomPictogramsPage extends StatefulWidget {
  const CustomPictogramsPage({super.key});

  @override
  State<StatefulWidget> createState() => _CustomPictogramsPageState();
}

class _CustomPictogramsPageState extends State<CustomPictogramsPage> {
  List<CustomPictogram> customPictograms = [];

  @override
  void initState() {
    super.initState();
    CustomPictogramRepository.instance.list().then((value) {
      setState(() {
        customPictograms = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>  EditCustomPictogramPage(
                  customPictogram: null,
                  onSave:  (id, key, imageBytes) async {
                  await CustomPictogramRepository.instance.insert(CustomPictogram(id: id, key: key, imageBytes: imageBytes));
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
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
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
                          onSave: (id, key, imageBytes) async {
                            await CustomPictogramRepository.instance.insert(CustomPictogram(id: id, key: key, imageBytes: imageBytes));
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
                  child: PictogramCard(
                    text: customPictograms[index].key,
                    error: false,
                    customPictogramId: customPictograms[index].id,
                  ),
                );
              },
              itemCount: customPictograms.length,
            ),
    );
  }
}
