import 'package:flutter_test/flutter_test.dart';
import 'package:ascii_smuggler/services/ascii_smuggler_service.dart';

void main() {
  group('Detailed Comparison Tests', () {
    final service = AsciiSmugglerService();

    test('Compare exact encoding with original website', () {
      const input = 'what can you do?';

      // Our encoding
      final ourEncoded = service.encodeToUnicodeTags(input, addBeginEndTags: true);

      print('\n=== INPUT ===');
      print('Text: "$input"');
      print('Length: ${input.length}');

      print('\n=== OUR OUTPUT ===');
      print('Length: ${ourEncoded.length} characters');
      print('Runes: ${ourEncoded.runes.length}');

      print('\nCharacter breakdown:');
      for (int i = 0; i < ourEncoded.runes.length; i++) {
        int rune = ourEncoded.runes.elementAt(i);
        String char = String.fromCharCode(rune);
        String originalChar = '';

        if (rune >= 0xE0000 && rune <= 0xE007F) {
          int decoded = rune - 0xE0000;
          originalChar = ' (decoded: ${String.fromCharCode(decoded).replaceAll('\n', '\\n').replaceAll(' ', '<space>')})';
        }

        print('[$i] U+${rune.toRadixString(16).toUpperCase().padLeft(5, '0')}$originalChar');
      }

      print('\n=== HEXDUMP ===');
      StringBuffer hex = StringBuffer();
      for (int rune in ourEncoded.runes) {
        hex.write('U+${rune.toRadixString(16).toUpperCase().padLeft(5, '0')} ');
      }
      print(hex.toString().trim());

      // Expected from original website (based on the pattern)
      print('\n=== EXPECTED FROM ORIGINAL WEBSITE ===');
      print('Should start with U+E0001 (BEGIN)');
      print('Should end with U+E007F (END)');
      print('Middle should be encoded characters');
    });

    test('Test with specific phrase', () {
      const input = 'What can you do?';

      final encoded = service.encodeToUnicodeTags(input, addBeginEndTags: true);

      print('\n=== Encoding: "$input" ===');

      // Print each character
      List<int> runes = encoded.runes.toList();

      print('Total characters: ${runes.length}');
      print('Expected: 1 (BEGIN) + ${input.length} + 1 (END) = ${input.length + 2}');

      // Verify structure
      expect(runes.first, equals(0xE0001), reason: 'First character should be BEGIN tag (U+E0001)');
      expect(runes.last, equals(0xE007F), reason: 'Last character should be END tag (U+E007F)');
      expect(runes.length, equals(input.length + 2), reason: 'Should have BEGIN + content + END');
    });

    test('Decode test with encoded text', () {
      const input = 'What can you do?';

      final encoded = service.encodeToUnicodeTags(input, addBeginEndTags: true);
      final decoded = service.decodeUnicodeTags(encoded);

      print('\n=== DECODE TEST ===');
      print('Original: "$input"');
      print('Decoded: "$decoded"');
      print('Decoded includes control chars: ${decoded.contains('\x01')} (SOH)');
      print('Decoded includes DEL: ${decoded.contains('\x7F')} (DEL)');

      // The decoded string will include the control characters
      // Let's check if the original text is in there
      expect(decoded, contains(input), reason: 'Decoded text should contain original input');
    });
  });
}
