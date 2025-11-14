import 'package:flutter/material.dart';

class DebugSection extends StatelessWidget {
  final TextEditingController debugController;
  final String debugFormat;
  final ValueChanged<String> onDebugFormatChanged;

  const DebugSection({
    super.key,
    required this.debugController,
    required this.debugFormat,
    required this.onDebugFormatChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Debug Output',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Spacer(),
                DropdownButton<String>(
                  value: debugFormat,
                  items: const [
                    DropdownMenuItem(value: 'unicode', child: Text('Unicode')),
                    DropdownMenuItem(value: 'hex', child: Text('Hexadecimal')),
                    DropdownMenuItem(value: 'binary', child: Text('Binary')),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      onDebugFormatChanged(value);
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            TextField(
              controller: debugController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Character codes will appear here...',
              ),
              maxLines: 8,
              readOnly: true,
              style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
