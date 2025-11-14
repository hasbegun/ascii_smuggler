// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'ASCII Smuggler';

  @override
  String get appDescription =>
      'Convert text to invisible Unicode encodings and decode hidden secrets';

  @override
  String get inputLabel => 'Input Text';

  @override
  String get inputHint => 'Enter text to encode or decode...';

  @override
  String get encodeAndCopy => 'Encode & Copy';

  @override
  String get decode => 'Decode';

  @override
  String get clear => 'Clear';

  @override
  String get hideAdvancedOptions => 'Hide Advanced Options';

  @override
  String get toggleAdvancedOptions => 'Toggle Advanced Options';

  @override
  String get output => 'Output';

  @override
  String containsInvisibleCharsHelper(int count) {
    return 'Contains $count invisible characters - Click Copy to use';
  }

  @override
  String invisibleCharsDebugPlaceholder(int count) {
    return '[$count invisible characters - see Debug Output below]';
  }

  @override
  String get encodingOptions => 'Encoding Options';

  @override
  String get decodingOptions => 'Decoding Options';

  @override
  String get unicodeTags => 'Unicode Tags';

  @override
  String get variantSelectors => 'Variant Selectors';

  @override
  String get sneakyBitsUtf8 => 'Sneaky Bits (UTF-8)';

  @override
  String get addBeginEndTags => 'Add BEGIN/END Tags';

  @override
  String get decodeUrl => 'Decode URL';

  @override
  String get highlightMode => 'Highlight Mode';

  @override
  String get autoDecode => 'Auto-decode';

  @override
  String get showDebug => 'Show Debug';

  @override
  String get otherInvisible => 'Other Invisible';

  @override
  String get sneakyBits => 'Sneaky Bits';

  @override
  String get inputOptions => 'Input Options';

  @override
  String get inputOptionsDescription =>
      'Click a button to copy the character to clipboard.';

  @override
  String get statistics => 'Statistics';

  @override
  String get total => 'Total';

  @override
  String get visible => 'Visible';

  @override
  String get invisible => 'Invisible';

  @override
  String get tags => 'Tags';

  @override
  String get zeroWidth => 'Zero Width';

  @override
  String get debugOutput => 'Debug Output';

  @override
  String get unicode => 'Unicode';

  @override
  String get hexadecimal => 'Hexadecimal';

  @override
  String get binary => 'Binary';

  @override
  String get debugHint => 'Character codes will appear here...';

  @override
  String get aboutAsciiSmuggler => 'About ASCII Smuggler';

  @override
  String get aboutDescription =>
      'ASCII Smuggler converts text to invisible Unicode encodings and decodes hidden secrets.';

  @override
  String get encodingMethods => 'Encoding Methods:';

  @override
  String get unicodeTagsDescription =>
      '• Unicode Tags: Uses invisible tag characters (U+E0000 block)';

  @override
  String get variantSelectorsDescription =>
      '• Variant Selectors: Adds variant selector characters';

  @override
  String get sneakyBitsDescription =>
      '• Sneaky Bits: Binary encoding with zero-width characters';

  @override
  String get useCases => 'Use Cases:';

  @override
  String get useCaseSecurityResearch => '• Security research';

  @override
  String get useCaseSteganography => '• Steganography demonstrations';

  @override
  String get useCaseUnicodeEncoding => '• Understanding Unicode encoding';

  @override
  String get close => 'Close';

  @override
  String get about => 'About';

  @override
  String get pleaseEnterTextToEncode => 'Please enter text to encode';

  @override
  String get pleaseEnterTextToDecode => 'Please enter text to decode';

  @override
  String get textCopiedToClipboard => 'Text copied to clipboard!';

  @override
  String get noHiddenTextDetected => 'No hidden text detected';

  @override
  String get noHiddenTextFound => 'No hidden text found';

  @override
  String get detectedHiddenText => 'Detected hidden text:\\n';

  @override
  String decodedMessages(int count) {
    return 'Decoded $count hidden message(s)';
  }

  @override
  String get cleared => 'Cleared';

  @override
  String copiedToClipboard(String label) {
    return 'Copied $label to clipboard';
  }
}
