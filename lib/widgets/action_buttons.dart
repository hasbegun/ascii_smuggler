import 'package:flutter/material.dart';

class ActionButtons extends StatelessWidget {
  final VoidCallback onEncode;
  final VoidCallback onDecode;
  final VoidCallback onClear;

  const ActionButtons({
    super.key,
    required this.onEncode,
    required this.onDecode,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: onEncode,
            icon: const Icon(Icons.lock),
            label: const Text('Encode & Copy'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(16),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: onDecode,
            icon: const Icon(Icons.lock_open),
            label: const Text('Decode'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(16),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: onClear,
            icon: const Icon(Icons.clear),
            label: const Text('Clear'),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.all(16),
            ),
          ),
        ),
      ],
    );
  }
}
