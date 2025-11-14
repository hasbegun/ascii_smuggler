import 'package:flutter_test/flutter_test.dart';
import 'package:ascii_smuggler/services/ascii_smuggler_service.dart';

void main() {
  group('Gemini AI Compatibility Tests', () {
    final service = AsciiSmugglerService();

    test('Format for AI models: visible + invisible', () {
      const input = 'what can you do?';

      // Encode
      final encoded = service.encodeToUnicodeTags(input, addBeginEndTags: true);

      // What should be copied to clipboard for AI models
      final clipboardText = input + encoded;

      print('\n=== FORMAT FOR GEMINI AI ===');
      print('Input: "$input"');
      print('Length of input: ${input.length}');
      print('Length of encoded: ${encoded.length}');
      print('Total clipboard length: ${clipboardText.length}');

      print('\n=== CLIPBOARD CONTENT ===');
      print('Visible part: "${clipboardText.substring(0, input.length)}"');
      print('Invisible part: ${clipboardText.length - input.length} characters');

      print('\n=== CHARACTER BREAKDOWN ===');
      for (int i = 0; i < clipboardText.length; i++) {
        int rune = clipboardText.runes.elementAt(i);
        String display = String.fromCharCode(rune);

        if (i < input.length) {
          print('[$i] VISIBLE: "$display" (U+${rune.toRadixString(16).toUpperCase().padLeft(4, '0')})');
        } else {
          String decoded = '';
          if (rune >= 0xE0000 && rune <= 0xE007F) {
            int decodedRune = rune - 0xE0000;
            decoded = ' -> "${String.fromCharCode(decodedRune)}"';
          }
          print('[$i] INVISIBLE: U+${rune.toRadixString(16).toUpperCase().padLeft(5, '0')}$decoded');
        }
      }

      // Verify structure
      expect(clipboardText.startsWith(input), true, reason: 'Should start with visible text');
      expect(clipboardText.length, greaterThan(input.length), reason: 'Should have invisible chars after visible text');
    });

    test('Test exact output for "what can you do?"', () {
      const input = 'what can you do?';
      final encoded = service.encodeToUnicodeTags(input, addBeginEndTags: true);
      final clipboardText = input + encoded;

      print('\n=== EXACT OUTPUT TEST ===');
      print('This is what gets pasted to Gemini:');
      print('---');
      print(clipboardText);
      print('---');
      print('(Note: Invisible characters won\'t display but are present)');

      // The clipboard should contain:
      // "what can you do?" (visible) + encoded version (invisible)
      expect(clipboardText.substring(0, input.length), equals(input));
    });
  });
}
