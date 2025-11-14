import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

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
    final l10n = AppLocalizations.of(context)!;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  l10n.debugOutput,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Spacer(),
                DropdownButton<String>(
                  value: debugFormat,
                  items: [
                    DropdownMenuItem(value: 'unicode', child: Text(l10n.unicode)),
                    DropdownMenuItem(value: 'hex', child: Text(l10n.hexadecimal)),
                    DropdownMenuItem(value: 'binary', child: Text(l10n.binary)),
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
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: l10n.debugHint,
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
