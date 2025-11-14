import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../l10n/app_localizations.dart';

class InputOptionsSection extends StatelessWidget {
  final Function(String) onStatusUpdate;

  const InputOptionsSection({
    super.key,
    required this.onStatusUpdate,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
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
              l10n.inputOptions,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white60,
                  ),
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: Text(
              l10n.inputOptionsDescription,
              style: const TextStyle(color: Colors.white60, fontSize: 12),
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 4,
            runSpacing: 4,
            children: [
              _buildQuickInsertButton(context, 'ZWSP', '\u200B'),
              _buildQuickInsertButton(context, 'ZWNJ', '\u200C'),
              _buildQuickInsertButton(context, 'ZWJ', '\u200D'),
              _buildQuickInsertButton(context, 'WJ', '\u2060'), // Word Joiner
              _buildQuickInsertButton(context, '×', '\u00D7'), // Multiplication sign
              _buildQuickInsertButton(context, '+', '\u002B'), // Plus sign
              _buildQuickInsertButton(context, 'ISEP', '\u001F'), // Information Separator
              _buildQuickInsertButton(context, 'LRM', '\u200E'), // Left-to-Right Mark
              _buildQuickInsertButton(context, 'RLM', '\u200F'), // Right-to-Left Mark
              _buildQuickInsertButton(context, 'LRE', '\u202A'), // Left-to-Right Embedding
              _buildQuickInsertButton(context, 'RLE', '\u202B'), // Right-to-Left Embedding
              _buildQuickInsertButton(context, 'PDF', '\u202C'), // Pop Directional Formatting
              _buildQuickInsertButton(context, 'LRO', '\u202D'), // Left-to-Right Override
              _buildQuickInsertButton(context, 'RLO', '\u202E'), // Right-to-Left Override
              _buildQuickInsertButton(context, 'LRI', '\u2066'), // Left-to-Right Isolate
              _buildQuickInsertButton(context, 'RLI', '\u2067'), // Right-to-Left Isolate
              _buildQuickInsertButton(context, 'FSI', '\u2068'), // First Strong Isolate
              _buildQuickInsertButton(context, 'PDI', '\u2069'), // Pop Directional Isolate
              _buildQuickInsertButton(context, 'SHY', '\u00AD'), // Soft Hyphen
              _buildQuickInsertButton(context, 'FNAP', '\u180E'), // Mongolian Vowel Separator
              _buildQuickInsertButton(context, 'MVS', '\u180E'), // Mongolian Vowel Separator (duplicate)
              _buildQuickInsertButton(context, '😊', '😊'), // Emoji
              _buildQuickInsertButton(context, '🎉', '🎉'), // Emoji
              _buildQuickInsertButton(context, '👍', '👍'), // Emoji
              _buildQuickInsertButton(context, '⚠️', '⚠️'), // Emoji
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickInsertButton(BuildContext context, String label, String char) {
    final l10n = AppLocalizations.of(context)!;
    return ElevatedButton(
      onPressed: () {
        Clipboard.setData(ClipboardData(text: char));
        onStatusUpdate(l10n.copiedToClipboard(label));
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