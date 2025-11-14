import 'package:flutter/material.dart';

class StatisticsSection extends StatelessWidget {
  final Map<String, int> statistics;

  const StatisticsSection({
    super.key,
    required this.statistics,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Statistics',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 16,
              runSpacing: 8,
              children: [
                _buildStatChip(context, 'Total', statistics['total'] ?? 0),
                _buildStatChip(context, 'Visible', statistics['visible'] ?? 0),
                _buildStatChip(context, 'Invisible', statistics['invisible'] ?? 0),
                _buildStatChip(context, 'Tags', statistics['tags'] ?? 0),
                _buildStatChip(context, 'Variant Selectors', statistics['variantSelectors'] ?? 0),
                _buildStatChip(context, 'Zero Width', statistics['zeroWidth'] ?? 0),
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
