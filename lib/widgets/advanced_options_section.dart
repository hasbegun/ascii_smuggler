import 'package:flutter/material.dart';

enum EncodingMode {
  unicodeTags,
  variantSelectors,
  sneakyBits,
}

class AdvancedOptionsSection extends StatelessWidget {
  // Encoding options
  final EncodingMode encodingMode;
  final bool addBeginEndTags;
  final ValueChanged<EncodingMode> onEncodingModeChanged;
  final ValueChanged<bool> onAddBeginEndTagsChanged;

  // Decoding options
  final bool decodeURL;
  final bool highlightMode;
  final bool autoDecodeEnabled;
  final bool showDebugEnabled;
  final ValueChanged<bool> onDecodeURLChanged;
  final ValueChanged<bool> onHighlightModeChanged;
  final ValueChanged<bool> onAutoDecodeChanged;
  final ValueChanged<bool> onShowDebugChanged;

  // Detection options
  final bool detectUnicodeTags;
  final bool detectVariantSelectors;
  final bool detectOtherInvisible;
  final bool detectSneakyBits;
  final ValueChanged<bool> onDetectUnicodeTagsChanged;
  final ValueChanged<bool> onDetectVariantSelectorsChanged;
  final ValueChanged<bool> onDetectOtherInvisibleChanged;
  final ValueChanged<bool> onDetectSneakyBitsChanged;

  const AdvancedOptionsSection({
    super.key,
    required this.encodingMode,
    required this.addBeginEndTags,
    required this.onEncodingModeChanged,
    required this.onAddBeginEndTagsChanged,
    required this.decodeURL,
    required this.highlightMode,
    required this.autoDecodeEnabled,
    required this.showDebugEnabled,
    required this.onDecodeURLChanged,
    required this.onHighlightModeChanged,
    required this.onAutoDecodeChanged,
    required this.onShowDebugChanged,
    required this.detectUnicodeTags,
    required this.detectVariantSelectors,
    required this.detectOtherInvisible,
    required this.detectSneakyBits,
    required this.onDetectUnicodeTagsChanged,
    required this.onDetectVariantSelectorsChanged,
    required this.onDetectOtherInvisibleChanged,
    required this.onDetectSneakyBitsChanged,
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
          // Encoding Options
          Center(
            child: Text(
              'Encoding Options',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white60,
                  ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildRadioOption('Unicode Tags', EncodingMode.unicodeTags),
              const SizedBox(width: 16),
              _buildRadioOption('Variant Selectors', EncodingMode.variantSelectors),
              const SizedBox(width: 16),
              _buildRadioOption('Sneaky Bits (UTF-8)', EncodingMode.sneakyBits),
            ],
          ),
          const SizedBox(height: 8),
          Center(
            child: CheckboxListTile(
              title: const Text('Add BEGIN/END Tags', style: TextStyle(color: Colors.white60)),
              value: addBeginEndTags,
              onChanged: (value) => onAddBeginEndTagsChanged(value!),
              dense: true,
              controlAffinity: ListTileControlAffinity.leading,
            ),
          ),
          const SizedBox(height: 16),

          // Decoding Options
          Center(
            child: Text(
              'Decoding Options',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white60,
                  ),
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildCheckboxOption('Decode URL', decodeURL, onDecodeURLChanged),
              _buildCheckboxOption('Highlight Mode', highlightMode, onHighlightModeChanged),
              _buildCheckboxOption('Auto-decode', autoDecodeEnabled, onAutoDecodeChanged),
              _buildCheckboxOption('Show Debug', showDebugEnabled, onShowDebugChanged),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildCheckboxOption('Unicode Tags', detectUnicodeTags, onDetectUnicodeTagsChanged),
              _buildCheckboxOption('Variant Selectors', detectVariantSelectors, onDetectVariantSelectorsChanged),
              _buildCheckboxOption('Other Invisible', detectOtherInvisible, onDetectOtherInvisibleChanged),
              _buildCheckboxOption('Sneaky Bits', detectSneakyBits, onDetectSneakyBitsChanged),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRadioOption(String label, EncodingMode mode) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio<EncodingMode>(
          value: mode,
          groupValue: encodingMode,
          onChanged: (value) => onEncodingModeChanged(value!),
          fillColor: WidgetStateProperty.all(Colors.white60),
        ),
        Text(label, style: const TextStyle(color: Colors.white60)),
      ],
    );
  }

  Widget _buildCheckboxOption(String label, bool value, ValueChanged<bool> onChanged) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Checkbox(
          value: value,
          onChanged: (newValue) => onChanged(newValue!),
          fillColor: WidgetStateProperty.all(Colors.white60),
        ),
        Text(label, style: const TextStyle(color: Colors.white60)),
      ],
    );
  }
}