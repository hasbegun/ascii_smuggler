import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputOptionsSection extends StatelessWidget {
  final Function(String) onStatusUpdate;

  const InputOptionsSection({
    super.key,
    required this.onStatusUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueGrey,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'Input Options',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white60,
                  ),
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: Text(
              'Click a button to copy the character to clipboard.',
              style: TextStyle(color: Colors.white60, fontSize: 12),
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 4,
            runSpacing: 4,
            children: [
              _buildQuickInsertButton('ZWSP', '\u200B'),
              _buildQuickInsertButton('ZWNJ', '\u200C'),
              _buildQuickInsertButton('ZWJ', '\u200D'),
              _buildQuickInsertButton('WJ', '\u2060'), // Word Joiner
              _buildQuickInsertButton('×', '\u00D7'), // Multiplication sign
              _buildQuickInsertButton('+', '\u002B'), // Plus sign
              _buildQuickInsertButton('ISEP', '\u001F'), // Information Separator
              _buildQuickInsertButton('LRM', '\u200E'), // Left-to-Right Mark
              _buildQuickInsertButton('RLM', '\u200F'), // Right-to-Left Mark
              _buildQuickInsertButton('LRE', '\u202A'), // Left-to-Right Embedding
              _buildQuickInsertButton('RLE', '\u202B'), // Right-to-Left Embedding
              _buildQuickInsertButton('PDF', '\u202C'), // Pop Directional Formatting
              _buildQuickInsertButton('LRO', '\u202D'), // Left-to-Right Override
              _buildQuickInsertButton('RLO', '\u202E'), // Right-to-Left Override
              _buildQuickInsertButton('LRI', '\u2066'), // Left-to-Right Isolate
              _buildQuickInsertButton('RLI', '\u2067'), // Right-to-Left Isolate
              _buildQuickInsertButton('FSI', '\u2068'), // First Strong Isolate
              _buildQuickInsertButton('PDI', '\u2069'), // Pop Directional Isolate
              _buildQuickInsertButton('SHY', '\u00AD'), // Soft Hyphen
              _buildQuickInsertButton('FNAP', '\u180E'), // Mongolian Vowel Separator
              _buildQuickInsertButton('MVS', '\u180E'), // Mongolian Vowel Separator (duplicate)
              _buildQuickInsertButton('😊', '😊'), // Emoji
              _buildQuickInsertButton('🎉', '🎉'), // Emoji
              _buildQuickInsertButton('👍', '👍'), // Emoji
              _buildQuickInsertButton('⚠️', '⚠️'), // Emoji
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickInsertButton(String label, String char) {
    return ElevatedButton(
      onPressed: () {
        Clipboard.setData(ClipboardData(text: char));
        onStatusUpdate('Copied $label to clipboard');
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        minimumSize: const Size(50, 36),
      ),
      child: Text(label, style: const TextStyle(fontSize: 12)),
    );
  }
}