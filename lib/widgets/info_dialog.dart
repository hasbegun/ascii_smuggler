import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class InfoDialog {
  static void show(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.aboutAsciiSmuggler),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(l10n.aboutDescription),
              const SizedBox(height: 16),
              Text(
                l10n.encodingMethods,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(l10n.unicodeTagsDescription),
              Text(l10n.variantSelectorsDescription),
              Text(l10n.sneakyBitsDescription),
              const SizedBox(height: 16),
              Text(
                l10n.useCases,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(l10n.useCaseSecurityResearch),
              Text(l10n.useCaseSteganography),
              Text(l10n.useCaseUnicodeEncoding),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.close),
          ),
        ],
      ),
    );
  }
}
