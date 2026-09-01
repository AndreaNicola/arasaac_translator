import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_it.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('it')
  ];

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About ARASAAC Translator'**
  String get about;

  /// No description provided for @aboutText.
  ///
  /// In en, this message translates to:
  /// **'ARASAAC Translator is a free tool to translate text to pictograms. It uses the ARASAAC pictogram set, which is licensed under Creative Commons BY-NC-SA 3.0. You can find more information about ARASAAC at http://arasaac.org'**
  String get aboutText;

  /// No description provided for @areYouSure.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this translation?'**
  String get areYouSure;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @confirmCustomPictogramDeleteText.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this custom pictogram?'**
  String get confirmCustomPictogramDeleteText;

  /// No description provided for @confirmCustomPictogramDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete custom pictogram'**
  String get confirmCustomPictogramDeleteTitle;

  /// No description provided for @confirmCustomPictogramSaveOverwrite.
  ///
  /// In en, this message translates to:
  /// **'This action is going to overwrite the existing custom pictogram.'**
  String get confirmCustomPictogramSaveOverwrite;

  /// No description provided for @confirmCustomPictogramSaveText.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to save this pictogram as a new custom pictogram?'**
  String get confirmCustomPictogramSaveText;

  /// No description provided for @confirmCustomPictogramSaveTitle.
  ///
  /// In en, this message translates to:
  /// **'Save custom pictogram'**
  String get confirmCustomPictogramSaveTitle;

  /// No description provided for @customPictograms.
  ///
  /// In en, this message translates to:
  /// **'Custom pictograms'**
  String get customPictograms;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @editText.
  ///
  /// In en, this message translates to:
  /// **'Edit text'**
  String get editText;

  /// No description provided for @enterText.
  ///
  /// In en, this message translates to:
  /// **'Enter text to translate'**
  String get enterText;

  /// No description provided for @loadedFrom.
  ///
  /// In en, this message translates to:
  /// **'Loaded from:'**
  String get loadedFrom;

  /// No description provided for @newCustomPictogram.
  ///
  /// In en, this message translates to:
  /// **'New custom pictogram'**
  String get newCustomPictogram;

  /// No description provided for @newCustomPictogramKey.
  ///
  /// In en, this message translates to:
  /// **'New custom pictogram word'**
  String get newCustomPictogramKey;

  /// No description provided for @noCustomPictograms.
  ///
  /// In en, this message translates to:
  /// **'You don\'\'t have any custom pictogram yet'**
  String get noCustomPictograms;

  /// No description provided for @noSavedTranslations.
  ///
  /// In en, this message translates to:
  /// **'You don\'\'t have any saved translation yet'**
  String get noSavedTranslations;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @saveTranslationName.
  ///
  /// In en, this message translates to:
  /// **'Save translation as...'**
  String get saveTranslationName;

  /// No description provided for @savedTranslations.
  ///
  /// In en, this message translates to:
  /// **'Saved translations'**
  String get savedTranslations;

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'ARASAAC translator'**
  String get title;

  /// No description provided for @editCustomPictogram.
  ///
  /// In en, this message translates to:
  /// **'Edit custom pictogram'**
  String get editCustomPictogram;

  /// No description provided for @editPictogram.
  ///
  /// In en, this message translates to:
  /// **'Edit pictogram'**
  String get editPictogram;

  /// No description provided for @appGuide.
  ///
  /// In en, this message translates to:
  /// **'User guide'**
  String get appGuide;

  /// No description provided for @appGuideIntroduction.
  ///
  /// In en, this message translates to:
  /// **'The app provides three main functionalities:'**
  String get appGuideIntroduction;

  /// No description provided for @appGuideFunctions1.
  ///
  /// In en, this message translates to:
  /// **'Translate a natural language sentence into a sequence of ARASAAC pictograms.'**
  String get appGuideFunctions1;

  /// No description provided for @appGuideFunctions2.
  ///
  /// In en, this message translates to:
  /// **'Manage a set of custom pictograms.'**
  String get appGuideFunctions2;

  /// No description provided for @appGuideFunctions3.
  ///
  /// In en, this message translates to:
  /// **'Save and load already made translations.'**
  String get appGuideFunctions3;

  /// No description provided for @appGuideFunctions4.
  ///
  /// In en, this message translates to:
  /// **'Create a printable PDF with the pictograms we have composed.'**
  String get appGuideFunctions4;

  /// No description provided for @appGuideFunctions1Step1.
  ///
  /// In en, this message translates to:
  /// **'Open the app and on the home screen you will find a text field where you can write the sentences to translate.'**
  String get appGuideFunctions1Step1;

  /// No description provided for @appGuideFunctions1Step2.
  ///
  /// In en, this message translates to:
  /// **'Enter the sentence you want to translate into the text field.'**
  String get appGuideFunctions1Step2;

  /// No description provided for @appGuideFunctions1Step3.
  ///
  /// In en, this message translates to:
  /// **'Wait a few seconds and your sentence will be translated into a sequence of ARASAAC pictograms.'**
  String get appGuideFunctions1Step3;

  /// No description provided for @appGuideFunctions1Sub1.
  ///
  /// In en, this message translates to:
  /// **'Merge two or more pictograms'**
  String get appGuideFunctions1Sub1;

  /// No description provided for @appGuideFunctions1Sub1Introduction.
  ///
  /// In en, this message translates to:
  /// **'To merge two pictograms you can drag one pictogram onto another:'**
  String get appGuideFunctions1Sub1Introduction;

  /// No description provided for @appGuideFunctions1Sub1Step1.
  ///
  /// In en, this message translates to:
  /// **'the image of the target pictogram will be preserved'**
  String get appGuideFunctions1Sub1Step1;

  /// No description provided for @appGuideFunctions1Sub1Step2.
  ///
  /// In en, this message translates to:
  /// **'the text of the pictogram will be the combination of the two pictograms.'**
  String get appGuideFunctions1Sub1Step2;

  /// No description provided for @appGuideFunctions1Sub2.
  ///
  /// In en, this message translates to:
  /// **'Edit the text of a pictogram'**
  String get appGuideFunctions1Sub2;

  /// No description provided for @appGuideFunctions1Sub2Introduction.
  ///
  /// In en, this message translates to:
  /// **'Tap a pictogram to open a window that allows you to edit its text'**
  String get appGuideFunctions1Sub2Introduction;

  /// No description provided for @appGuideFunction2Step1.
  ///
  /// In en, this message translates to:
  /// **'In the “Custom Pictograms” section, click on the “Add” button to add a new custom pictogram.'**
  String get appGuideFunction2Step1;

  /// No description provided for @appGuideFunction2Step1Sub1.
  ///
  /// In en, this message translates to:
  /// **'enter the text of the new pictogram'**
  String get appGuideFunction2Step1Sub1;

  /// No description provided for @appGuideFunction2Step1Sub2.
  ///
  /// In en, this message translates to:
  /// **'choose whether to insert the image using the camera or directly from the device’s gallery.'**
  String get appGuideFunction2Step1Sub2;

  /// No description provided for @appGuideFunction2Step2.
  ///
  /// In en, this message translates to:
  /// **'You can edit existing pictograms by tapping on the pictogram to be edited.'**
  String get appGuideFunction2Step2;

  /// No description provided for @appGuideFunction2Step3.
  ///
  /// In en, this message translates to:
  /// **'You can delete existing pictograms by tapping on the “Delete” button of the pictogram to be deleted.'**
  String get appGuideFunction2Step3;

  /// No description provided for @appGuideFunctions2Sub1.
  ///
  /// In en, this message translates to:
  /// **'Save a customized version of an ARASAAC pictogram'**
  String get appGuideFunctions2Sub1;

  /// No description provided for @appGuideFunctions2Sub1Introduction.
  ///
  /// In en, this message translates to:
  /// **'If you have edited the text of a pictogram, you can save it as a custom pictogram by long tapping on the pictogram. A confirmation message will appear asking you if you want to save the custom pictogram. If you confirm, the custom pictogram will be saved and you will be able to use it in the future.'**
  String get appGuideFunctions2Sub1Introduction;

  /// No description provided for @appGuideFunctions3Step1.
  ///
  /// In en, this message translates to:
  /// **'In the “Translations” section, click on the “Save” button to save the current translation. You will be asked to enter a name for the translation. The translation will be saved and you will be able to load it in the future'**
  String get appGuideFunctions3Step1;

  /// No description provided for @appGuideFunctions3Step2.
  ///
  /// In en, this message translates to:
  /// **'You can load a saved translation in the “Translations” section by tapping on the translation to be loaded'**
  String get appGuideFunctions3Step2;

  /// No description provided for @appGuideFunctions4Step1.
  ///
  /// In en, this message translates to:
  /// **'After composing the sequence of pictograms, you can create a PDF by tapping on the “PDF” button. The PDF will be created and you will be able to print it or share it with other apps.'**
  String get appGuideFunctions4Step1;

  /// No description provided for @appGuideFunctions4Step2.
  ///
  /// In en, this message translates to:
  /// **'The app will produce a PDF with the translated text and the pictograms used'**
  String get appGuideFunctions4Step2;

  /// No description provided for @appGuideFunctions4Step3.
  ///
  /// In en, this message translates to:
  /// **'The file can be shared, saved or printed by interacting with the options of the operating system.'**
  String get appGuideFunctions4Step3;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'it'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'it':
      return AppLocalizationsIt();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
