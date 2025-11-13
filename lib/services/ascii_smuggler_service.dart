/// Service class for ASCII Smuggling operations
/// Converts text to invisible Unicode encodings and decodes hidden messages
class AsciiSmugglerService {
  // Unicode Tag block starts at U+E0000
  static const int tagOffset = 0xE0000;

  // Variant Selector offset (configurable)
  static const int variantSelectorBase = 0xFE00;

  // Common invisible Unicode characters
  static const String zeroWidthSpace = '\u200B';
  static const String zeroWidthNonJoiner = '\u200C';
  static const String zeroWidthJoiner = '\u200D';

  /// Convert text to Unicode Tag characters
  /// Each character is offset by 0xE0000 to become invisible
  String encodeToUnicodeTags(String input, {bool addBeginEndTags = true}) {
    if (input.isEmpty) return '';

    String encoded = input.runes.map((rune) {
      return String.fromCharCode(tagOffset + rune);
    }).join();

    if (addBeginEndTags) {
      // Add BEGIN tag (U+E0001 = SOH) and END tag (U+E007F = DELETE)
      const String tagBegin = '\u{E0001}'; // Start of Heading
      const String tagEnd = '\u{E007F}';   // Delete
      encoded = tagBegin + encoded + tagEnd;
    }

    return encoded;
  }

  /// Decode Unicode Tag characters back to normal text
  String decodeUnicodeTags(String input) {
    if (input.isEmpty) return '';

    StringBuffer decoded = StringBuffer();

    for (int rune in input.runes) {
      // Check if it's in the tag character range (U+E0000 to U+E007F)
      if (rune >= tagOffset && rune <= tagOffset + 0x7F) {
        decoded.writeCharCode(rune - tagOffset);
      }
    }

    return decoded.toString();
  }

  /// Encode text using Variant Selectors
  /// Uses VS2 (U+FE01) by default with configurable offset
  String encodeToVariantSelectors(String input, {int vs2Offset = 16}) {
    if (input.isEmpty) return '';

    StringBuffer encoded = StringBuffer();

    for (int i = 0; i < input.length; i++) {
      String char = input[i];
      encoded.write(char);

      // Add variant selector after each character
      // VS1 is U+FE00, VS2 is U+FE01, etc.
      int variantSelector = variantSelectorBase + vs2Offset;
      if (variantSelector <= 0xFE0F) {
        encoded.writeCharCode(variantSelector);
      }
    }

    return encoded.toString();
  }

  /// Decode Variant Selectors
  String decodeVariantSelectors(String input) {
    if (input.isEmpty) return '';

    StringBuffer decoded = StringBuffer();

    for (int rune in input.runes) {
      // Skip variant selectors (U+FE00 to U+FE0F)
      if (rune < 0xFE00 || rune > 0xFE0F) {
        decoded.writeCharCode(rune);
      }
    }

    return decoded.toString();
  }

  /// Encode text using sneaky bits (binary encoding with custom characters)
  /// Each character is converted to 8-bit binary and represented with custom chars
  String encodeToSneakyBits(String input, {
    String zeroChar = '\u200B', // ZWSP
    String oneChar = '\u200C',  // ZWNJ
  }) {
    if (input.isEmpty) return '';

    StringBuffer encoded = StringBuffer();

    for (int rune in input.runes) {
      // Convert to 8-bit binary
      String binary = rune.toRadixString(2).padLeft(8, '0');

      // Replace 0 and 1 with custom characters
      for (int i = 0; i < binary.length; i++) {
        encoded.write(binary[i] == '0' ? zeroChar : oneChar);
      }
    }

    return encoded.toString();
  }

  /// Decode sneaky bits back to text
  String decodeSneakyBits(String input, {
    String zeroChar = '\u200B', // ZWSP
    String oneChar = '\u200C',  // ZWNJ
  }) {
    if (input.isEmpty) return '';

    StringBuffer binaryString = StringBuffer();

    // Extract binary representation
    for (int rune in input.runes) {
      String char = String.fromCharCode(rune);
      if (char == zeroChar) {
        binaryString.write('0');
      } else if (char == oneChar) {
        binaryString.write('1');
      }
    }

    String binary = binaryString.toString();
    if (binary.length % 8 != 0) {
      return ''; // Invalid encoding
    }

    StringBuffer decoded = StringBuffer();

    // Convert every 8 bits to a character
    for (int i = 0; i < binary.length; i += 8) {
      String byte = binary.substring(i, i + 8);
      int charCode = int.parse(byte, radix: 2);
      decoded.writeCharCode(charCode);
    }

    return decoded.toString();
  }

  /// Detect and decode any hidden text in the input
  /// Returns a map with detection results
  Map<String, String> detectAndDecode(String input) {
    Map<String, String> results = {};

    // Try Unicode Tags
    String tagDecoded = decodeUnicodeTags(input);
    if (tagDecoded.isNotEmpty) {
      results['Unicode Tags'] = tagDecoded;
    }

    // Try Variant Selectors
    String vsDecoded = decodeVariantSelectors(input);
    if (vsDecoded != input && vsDecoded.isNotEmpty) {
      results['Variant Selectors'] = vsDecoded;
    }

    // Try Sneaky Bits
    String sneakyDecoded = decodeSneakyBits(input);
    if (sneakyDecoded.isNotEmpty) {
      results['Sneaky Bits'] = sneakyDecoded;
    }

    return results;
  }

  /// Get statistics about the text
  Map<String, int> getStatistics(String input) {
    Map<String, int> stats = {
      'total': 0,
      'visible': 0,
      'invisible': 0,
      'tags': 0,
      'variantSelectors': 0,
      'zeroWidth': 0,
    };

    for (int rune in input.runes) {
      stats['total'] = stats['total']! + 1;

      // Check for tag characters
      if (rune >= tagOffset && rune <= tagOffset + 0x7F) {
        stats['tags'] = stats['tags']! + 1;
        stats['invisible'] = stats['invisible']! + 1;
      }
      // Check for variant selectors
      else if (rune >= 0xFE00 && rune <= 0xFE0F) {
        stats['variantSelectors'] = stats['variantSelectors']! + 1;
        stats['invisible'] = stats['invisible']! + 1;
      }
      // Check for zero-width characters
      else if (rune == 0x200B || rune == 0x200C || rune == 0x200D) {
        stats['zeroWidth'] = stats['zeroWidth']! + 1;
        stats['invisible'] = stats['invisible']! + 1;
      }
      else {
        stats['visible'] = stats['visible']! + 1;
      }
    }

    return stats;
  }

  /// Get debug output for the text (show character codes)
  String getDebugOutput(String input, {String format = 'unicode'}) {
    StringBuffer output = StringBuffer();

    for (int rune in input.runes) {
      String char = String.fromCharCode(rune);

      switch (format) {
        case 'binary':
          output.writeln('$char: ${rune.toRadixString(2).padLeft(16, '0')}');
          break;
        case 'hex':
          output.writeln('$char: 0x${rune.toRadixString(16).toUpperCase().padLeft(4, '0')}');
          break;
        case 'unicode':
        default:
          output.writeln('$char: U+${rune.toRadixString(16).toUpperCase().padLeft(4, '0')}');
          break;
      }
    }

    return output.toString();
  }
}
