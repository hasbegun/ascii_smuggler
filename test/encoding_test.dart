import 'package:flutter_test/flutter_test.dart';
import 'package:ascii_smuggler/services/ascii_smuggler_service.dart';

void main() {
  group('ASCII Smuggler Encoding Tests', () {
    final service = AsciiSmugglerService();

    test('Unicode Tags encoding matches original website output', () {
      const input = 'This is a test text';

      // Encode with BEGIN/END tags
      final encoded = service.encodeToUnicodeTags(input, addBeginEndTags: true);

      // Verify the output matches the original website
      final expectedCodes = [
        0xE0001, // BEGIN tag
        0xE0054, // T
        0xE0068, // h
        0xE0069, // i
        0xE0073, // s
        0xE0020, // (space)
        0xE0069, // i
        0xE0073, // s
        0xE0020, // (space)
        0xE0061, // a
        0xE0020, // (space)
        0xE0074, // t
        0xE0065, // e
        0xE0073, // s
        0xE0074, // t
        0xE0020, // (space)
        0xE0074, // t
        0xE0065, // e
        0xE0078, // x
        0xE0074, // t
        0xE007F, // END tag
      ];

      final actualCodes = encoded.runes.toList();

      expect(actualCodes.length, equals(expectedCodes.length),
          reason: 'Encoded length should match expected length');

      for (int i = 0; i < expectedCodes.length; i++) {
        expect(actualCodes[i], equals(expectedCodes[i]),
            reason: 'Character at index $i should be U+${expectedCodes[i].toRadixString(16).toUpperCase().padLeft(5, '0')}');
      }

      // Print debug info
      print('Input: $input');
      print('Encoded output codes:');
      for (int i = 0; i < actualCodes.length; i++) {
        print('  U+${actualCodes[i].toRadixString(16).toUpperCase().padLeft(5, '0')}');
      }
    });

    test('Unicode Tags decoding works correctly', () {
      const input = 'This is a test text';

      // Encode and then decode
      final encoded = service.encodeToUnicodeTags(input, addBeginEndTags: true);
      final decoded = service.decodeUnicodeTags(encoded);

      // The decoded text should include BEGIN (0x01) and END (0x7F) characters
      // Let's verify the main content is there
      expect(decoded, contains('This is a test text'),
          reason: 'Decoded text should contain the original input');
    });

    test('Unicode Tags encoding without BEGIN/END tags', () {
      const input = 'Test';

      final encoded = service.encodeToUnicodeTags(input, addBeginEndTags: false);

      final expectedCodes = [
        0xE0054, // T
        0xE0065, // e
        0xE0073, // s
        0xE0074, // t
      ];

      final actualCodes = encoded.runes.toList();

      expect(actualCodes, equals(expectedCodes),
          reason: 'Should encode without BEGIN/END tags');
    });

    test('Variant Selectors encoding', () {
      const input = 'Test';

      final encoded = service.encodeToVariantSelectors(input, vs2Offset: 1);
      final decoded = service.decodeVariantSelectors(encoded);

      expect(decoded, equals(input),
          reason: 'Decoded text should match original input');
    });

    test('Sneaky Bits encoding and decoding', () {
      const input = 'Hi';

      final encoded = service.encodeToSneakyBits(input);
      final decoded = service.decodeSneakyBits(encoded);

      expect(decoded, equals(input),
          reason: 'Decoded text should match original input');
    });

    test('Statistics calculation', () {
      const input = 'Test';
      final encoded = service.encodeToUnicodeTags(input, addBeginEndTags: true);

      final stats = service.getStatistics(encoded);

      expect(stats['total'], equals(6), // BEGIN + T + e + s + t + END
          reason: 'Total characters should be 6');
      expect(stats['invisible'], equals(6),
          reason: 'All characters should be invisible');
      expect(stats['tags'], equals(6),
          reason: 'All characters should be tag characters');
    });
  });
}
