import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_zh.dart';

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
    Locale('es'),
    Locale('ja'),
    Locale('ko'),
    Locale('zh'),
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'ASCII Smuggler'**
  String get appTitle;

  /// Main description of the app
  ///
  /// In en, this message translates to:
  /// **'Convert text to invisible Unicode encodings and decode hidden secrets'**
  String get appDescription;

  /// Label for input text field
  ///
  /// In en, this message translates to:
  /// **'Input Text'**
  String get inputLabel;

  /// Hint text for input field
  ///
  /// In en, this message translates to:
  /// **'Enter text to encode or decode...'**
  String get inputHint;

  /// Button text for encoding and copying
  ///
  /// In en, this message translates to:
  /// **'Encode & Copy'**
  String get encodeAndCopy;

  /// Button text for decoding
  ///
  /// In en, this message translates to:
  /// **'Decode'**
  String get decode;

  /// Button text for clearing inputs
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clear;

  /// Button text to hide advanced options
  ///
  /// In en, this message translates to:
  /// **'Hide Advanced Options'**
  String get hideAdvancedOptions;

  /// Button text to show advanced options
  ///
  /// In en, this message translates to:
  /// **'Toggle Advanced Options'**
  String get toggleAdvancedOptions;

  /// Label for output field
  ///
  /// In en, this message translates to:
  /// **'Output'**
  String get output;

  /// Helper text showing invisible character count
  ///
  /// In en, this message translates to:
  /// **'Contains {count} invisible characters - Click Copy to use'**
  String containsInvisibleCharsHelper(int count);

  /// Placeholder text for invisible characters
  ///
  /// In en, this message translates to:
  /// **'[{count} invisible characters - see Debug Output below]'**
  String invisibleCharsDebugPlaceholder(int count);

  /// Section title for encoding options
  ///
  /// In en, this message translates to:
  /// **'Encoding Options'**
  String get encodingOptions;

  /// Section title for decoding options
  ///
  /// In en, this message translates to:
  /// **'Decoding Options'**
  String get decodingOptions;

  /// Unicode Tags encoding method
  ///
  /// In en, this message translates to:
  /// **'Unicode Tags'**
  String get unicodeTags;

  /// Variant Selectors encoding method
  ///
  /// In en, this message translates to:
  /// **'Variant Selectors'**
  String get variantSelectors;

  /// Sneaky Bits encoding method
  ///
  /// In en, this message translates to:
  /// **'Sneaky Bits (UTF-8)'**
  String get sneakyBitsUtf8;

  /// Checkbox option to add begin/end tags
  ///
  /// In en, this message translates to:
  /// **'Add BEGIN/END Tags'**
  String get addBeginEndTags;

  /// Decode URL option
  ///
  /// In en, this message translates to:
  /// **'Decode URL'**
  String get decodeUrl;

  /// Highlight mode option
  ///
  /// In en, this message translates to:
  /// **'Highlight Mode'**
  String get highlightMode;

  /// Auto-decode option
  ///
  /// In en, this message translates to:
  /// **'Auto-decode'**
  String get autoDecode;

  /// Show debug option
  ///
  /// In en, this message translates to:
  /// **'Show Debug'**
  String get showDebug;

  /// Other invisible characters option
  ///
  /// In en, this message translates to:
  /// **'Other Invisible'**
  String get otherInvisible;

  /// Sneaky bits detection option
  ///
  /// In en, this message translates to:
  /// **'Sneaky Bits'**
  String get sneakyBits;

  /// Section title for input options
  ///
  /// In en, this message translates to:
  /// **'Input Options'**
  String get inputOptions;

  /// Description for input options section
  ///
  /// In en, this message translates to:
  /// **'Click a button to copy the character to clipboard.'**
  String get inputOptionsDescription;

  /// Statistics section title
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get statistics;

  /// Total count label
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// Visible characters label
  ///
  /// In en, this message translates to:
  /// **'Visible'**
  String get visible;

  /// Invisible characters label
  ///
  /// In en, this message translates to:
  /// **'Invisible'**
  String get invisible;

  /// Tags count label
  ///
  /// In en, this message translates to:
  /// **'Tags'**
  String get tags;

  /// Zero width characters label
  ///
  /// In en, this message translates to:
  /// **'Zero Width'**
  String get zeroWidth;

  /// Debug output section title
  ///
  /// In en, this message translates to:
  /// **'Debug Output'**
  String get debugOutput;

  /// Unicode format option
  ///
  /// In en, this message translates to:
  /// **'Unicode'**
  String get unicode;

  /// Hexadecimal format option
  ///
  /// In en, this message translates to:
  /// **'Hexadecimal'**
  String get hexadecimal;

  /// Binary format option
  ///
  /// In en, this message translates to:
  /// **'Binary'**
  String get binary;

  /// Hint text for debug output
  ///
  /// In en, this message translates to:
  /// **'Character codes will appear here...'**
  String get debugHint;

  /// About dialog title
  ///
  /// In en, this message translates to:
  /// **'About ASCII Smuggler'**
  String get aboutAsciiSmuggler;

  /// About dialog description
  ///
  /// In en, this message translates to:
  /// **'ASCII Smuggler converts text to invisible Unicode encodings and decodes hidden secrets.'**
  String get aboutDescription;

  /// Encoding methods section in about dialog
  ///
  /// In en, this message translates to:
  /// **'Encoding Methods:'**
  String get encodingMethods;

  /// Unicode tags method description
  ///
  /// In en, this message translates to:
  /// **'• Unicode Tags: Uses invisible tag characters (U+E0000 block)'**
  String get unicodeTagsDescription;

  /// Variant selectors method description
  ///
  /// In en, this message translates to:
  /// **'• Variant Selectors: Adds variant selector characters'**
  String get variantSelectorsDescription;

  /// Sneaky bits method description
  ///
  /// In en, this message translates to:
  /// **'• Sneaky Bits: Binary encoding with zero-width characters'**
  String get sneakyBitsDescription;

  /// Use cases section in about dialog
  ///
  /// In en, this message translates to:
  /// **'Use Cases:'**
  String get useCases;

  /// Security research use case
  ///
  /// In en, this message translates to:
  /// **'• Security research'**
  String get useCaseSecurityResearch;

  /// Steganography use case
  ///
  /// In en, this message translates to:
  /// **'• Steganography demonstrations'**
  String get useCaseSteganography;

  /// Unicode encoding use case
  ///
  /// In en, this message translates to:
  /// **'• Understanding Unicode encoding'**
  String get useCaseUnicodeEncoding;

  /// Close button text
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// About tooltip
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// Status message when input is empty for encoding
  ///
  /// In en, this message translates to:
  /// **'Please enter text to encode'**
  String get pleaseEnterTextToEncode;

  /// Status message when input is empty for decoding
  ///
  /// In en, this message translates to:
  /// **'Please enter text to decode'**
  String get pleaseEnterTextToDecode;

  /// Status message when text is copied
  ///
  /// In en, this message translates to:
  /// **'Text copied to clipboard!'**
  String get textCopiedToClipboard;

  /// Status message when no hidden text found
  ///
  /// In en, this message translates to:
  /// **'No hidden text detected'**
  String get noHiddenTextDetected;

  /// Output message when no hidden text found
  ///
  /// In en, this message translates to:
  /// **'No hidden text found'**
  String get noHiddenTextFound;

  /// Output header for detected hidden text
  ///
  /// In en, this message translates to:
  /// **'Detected hidden text:\\n'**
  String get detectedHiddenText;

  /// Status message showing decoded message count
  ///
  /// In en, this message translates to:
  /// **'Decoded {count} hidden message(s)'**
  String decodedMessages(int count);

  /// Status message when fields are cleared
  ///
  /// In en, this message translates to:
  /// **'Cleared'**
  String get cleared;

  /// Status message when character is copied
  ///
  /// In en, this message translates to:
  /// **'Copied {label} to clipboard'**
  String copiedToClipboard(String label);
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
      <String>['en', 'es', 'ja', 'ko', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'ja':
      return AppLocalizationsJa();
    case 'ko':
      return AppLocalizationsKo();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
