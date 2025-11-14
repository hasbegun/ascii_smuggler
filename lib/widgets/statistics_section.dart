import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class StatisticsSection extends StatelessWidget {
  final Map<String, int> statistics;

  const StatisticsSection({
    super.key,
    required this.statistics,
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
            Text(
              l10n.statistics,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 16,
              runSpacing: 8,
              children: [
                _buildStatChip(context, l10n.total, statistics['total'] ?? 0),
                _buildStatChip(context, l10n.visible, statistics['visible'] ?? 0),
                _buildStatChip(context, l10n.invisible, statistics['invisible'] ?? 0),
                _buildStatChip(context, l10n.tags, statistics['tags'] ?? 0),
                _buildStatChip(context, l10n.variantSelectors, statistics['variantSelectors'] ?? 0),
                _buildStatChip(context, l10n.zeroWidth, statistics['zeroWidth'] ?? 0),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatChip(BuildContext context, String label, int count) {
    return Chip(
      label: Text('$label: $count'),
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
    );
  }
}
