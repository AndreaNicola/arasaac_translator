// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get about => 'About ARASAAC Translator';

  @override
  String get aboutText =>
      'ARASAAC Translator is a free tool to translate text to pictograms. It uses the ARASAAC pictogram set, which is licensed under Creative Commons BY-NC-SA 3.0. You can find more information about ARASAAC at http://arasaac.org';

  @override
  String get areYouSure => 'Are you sure you want to delete this translation?';

  @override
  String get cancel => 'Cancel';

  @override
  String get confirm => 'Confirm';

  @override
  String get confirmCustomPictogramDeleteText =>
      'Are you sure you want to delete this custom pictogram?';

  @override
  String get confirmCustomPictogramDeleteTitle => 'Delete custom pictogram';

  @override
  String get confirmCustomPictogramSaveOverwrite =>
      'This action is going to overwrite the existing custom pictogram.';

  @override
  String get confirmCustomPictogramSaveText =>
      'Are you sure you want to save this pictogram as a new custom pictogram?';

  @override
  String get confirmCustomPictogramSaveTitle => 'Save custom pictogram';

  @override
  String get customPictograms => 'Custom pictograms';

  @override
  String get delete => 'Delete';

  @override
  String get editText => 'Edit text';

  @override
  String get enterText => 'Enter text to translate';

  @override
  String get loadedFrom => 'Loaded from:';

  @override
  String get newCustomPictogram => 'New custom pictogram';

  @override
  String get newCustomPictogramKey => 'New custom pictogram word';

  @override
  String get noCustomPictograms => 'You don\'t have any custom pictogram yet';

  @override
  String get noSavedTranslations => 'You don\'t have any saved translation yet';

  @override
  String get save => 'Save';

  @override
  String get saveTranslationName => 'Save translation as...';

  @override
  String get savedTranslations => 'Saved translations';

  @override
  String get title => 'ARASAAC translator';

  @override
  String get editCustomPictogram => 'Edit custom pictogram';

  @override
  String get editPictogram => 'Edit pictogram';

  @override
  String get appGuide => 'User guide';

  @override
  String get appGuideIntroduction =>
      'The app provides three main functionalities:';

  @override
  String get appGuideFunctions1 =>
      'Translate a natural language sentence into a sequence of ARASAAC pictograms.';

  @override
  String get appGuideFunctions2 => 'Manage a set of custom pictograms.';

  @override
  String get appGuideFunctions3 => 'Save and load already made translations.';

  @override
  String get appGuideFunctions4 =>
      'Create a printable PDF with the pictograms we have composed.';

  @override
  String get appGuideFunctions1Step1 =>
      'Open the app and on the home screen you will find a text field where you can write the sentences to translate.';

  @override
  String get appGuideFunctions1Step2 =>
      'Enter the sentence you want to translate into the text field.';

  @override
  String get appGuideFunctions1Step3 =>
      'Wait a few seconds and your sentence will be translated into a sequence of ARASAAC pictograms.';

  @override
  String get appGuideFunctions1Sub1 => 'Merge two or more pictograms';

  @override
  String get appGuideFunctions1Sub1Introduction =>
      'To merge two pictograms you can drag one pictogram onto another:';

  @override
  String get appGuideFunctions1Sub1Step1 =>
      'the image of the target pictogram will be preserved';

  @override
  String get appGuideFunctions1Sub1Step2 =>
      'the text of the pictogram will be the combination of the two pictograms.';

  @override
  String get appGuideFunctions1Sub2 => 'Edit the text of a pictogram';

  @override
  String get appGuideFunctions1Sub2Introduction =>
      'Tap a pictogram to open a window that allows you to edit its text';

  @override
  String get appGuideFunction2Step1 =>
      'In the “Custom Pictograms” section, click on the “Add” button to add a new custom pictogram.';

  @override
  String get appGuideFunction2Step1Sub1 =>
      'enter the text of the new pictogram';

  @override
  String get appGuideFunction2Step1Sub2 =>
      'choose whether to insert the image using the camera or directly from the device’s gallery.';

  @override
  String get appGuideFunction2Step2 =>
      'You can edit existing pictograms by tapping on the pictogram to be edited.';

  @override
  String get appGuideFunction2Step3 =>
      'You can delete existing pictograms by tapping on the “Delete” button of the pictogram to be deleted.';

  @override
  String get appGuideFunctions2Sub1 =>
      'Save a customized version of an ARASAAC pictogram';

  @override
  String get appGuideFunctions2Sub1Introduction =>
      'If you have edited the text of a pictogram, you can save it as a custom pictogram by long tapping on the pictogram. A confirmation message will appear asking you if you want to save the custom pictogram. If you confirm, the custom pictogram will be saved and you will be able to use it in the future.';

  @override
  String get appGuideFunctions3Step1 =>
      'In the “Translations” section, click on the “Save” button to save the current translation. You will be asked to enter a name for the translation. The translation will be saved and you will be able to load it in the future';

  @override
  String get appGuideFunctions3Step2 =>
      'You can load a saved translation in the “Translations” section by tapping on the translation to be loaded';

  @override
  String get appGuideFunctions4Step1 =>
      'After composing the sequence of pictograms, you can create a PDF by tapping on the “PDF” button. The PDF will be created and you will be able to print it or share it with other apps.';

  @override
  String get appGuideFunctions4Step2 =>
      'The app will produce a PDF with the translated text and the pictograms used';

  @override
  String get appGuideFunctions4Step3 =>
      'The file can be shared, saved or printed by interacting with the options of the operating system.';
}
