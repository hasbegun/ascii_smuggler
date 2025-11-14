import 'package:flutter/material.dart';

class InfoDialog {
  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('About ASCII Smuggler'),
        content: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'ASCII Smuggler converts text to invisible Unicode encodings '
                'and decodes hidden secrets.',
              ),
              SizedBox(height: 16),
              Text(
                'Encoding Methods:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('• Unicode Tags: Uses invisible tag characters (U+E0000 block)'),
              Text('• Variant Selectors: Adds variant selector characters'),
              Text('• Sneaky Bits: Binary encoding with zero-width characters'),
              SizedBox(height: 16),
              Text(
                'Use Cases:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('• Security research'),
              Text('• Steganography demonstrations'),
              Text('• Understanding Unicode encoding'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
