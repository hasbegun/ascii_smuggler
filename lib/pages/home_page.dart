import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../services/ascii_smuggler_service.dart';
import '../widgets/action_buttons.dart';
import '../widgets/advanced_options_section.dart';
import '../widgets/debug_section.dart';
import '../widgets/info_dialog.dart';
import '../widgets/input_options_section.dart';
import '../widgets/statistics_section.dart';

class AsciiSmugglerHomePage extends StatefulWidget {
  const AsciiSmugglerHomePage({super.key});

  @override
  State<AsciiSmugglerHomePage> createState() => _AsciiSmugglerHomePageState();
}

class _AsciiSmugglerHomePageState extends State<AsciiSmugglerHomePage> {
  final AsciiSmugglerService _service = AsciiSmugglerService();
  final TextEditingController _inputController = TextEditingController();
  final TextEditingController _outputController = TextEditingController();
  final TextEditingController _debugController = TextEditingController();

  // Encoding options
  EncodingMode _encodingMode = EncodingMode.unicodeTags;
  bool _addBeginEndTags = false; // Default to false for better AI compatibility
  int _vs2Offset = 16;
  final String _zeroChar = '\u200B'; // ZWSP
  final String _oneChar = '\u200C'; // ZWNJ

  // Decoding options
  bool _decodeURL = false;
  bool _highlightMode = false;
  bool _autoDecodeEnabled = false;
  bool _showDebugEnabled = false;

  // Detection options
  bool _detectUnicodeTags = true;
  bool _detectVariantSelectors = true;
  bool _detectOtherInvisible = true;
  bool _detectSneakyBits = true;

  // Debug options
  String _debugFormat = 'unicode';
  bool _showAdvancedOptions = false;

  // Status message
  String _statusMessage = '';

  // Statistics
  Map<String, int> _statistics = {};

  @override
  void dispose() {
    _inputController.dispose();
    _outputController.dispose();
    _debugController.dispose();
    super.dispose();
  }

  void _encode() {
    String input = _inputController.text;
    if (input.isEmpty) {
      _setStatus('Please enter text to encode');
      return;
    }

    String encoded = '';
    switch (_encodingMode) {
      case EncodingMode.unicodeTags:
        encoded = _service.encodeToUnicodeTags(
          input,
          addBeginEndTags: _addBeginEndTags,
        );
        break;
      case EncodingMode.variantSelectors:
        encoded = _service.encodeToVariantSelectors(
          input,
          vs2Offset: _vs2Offset,
        );
        break;
      case EncodingMode.sneakyBits:
        encoded = _service.encodeToSneakyBits(
          input,
          zeroChar: _zeroChar,
          oneChar: _oneChar,
        );
        break;
    }

    setState(() {
      _outputController.text = encoded;
      _updateDebugOutput(encoded);
      _updateStatistics(encoded);
      // Automatically show debug output when encoding
      if (!_showDebugEnabled) {
        _showDebugEnabled = true;
      }
    });

    // Copy ONLY the invisible encoded text to clipboard
    // This is the steganographic payload that should be invisible when pasted
    Clipboard.setData(ClipboardData(text: encoded));
    _setStatus('Text copied to clipboard!');
  }

  void _decode() {
    String input = _inputController.text;
    if (input.isEmpty) {
      _setStatus('Please enter text to decode');
      return;
    }

    // URL decode if enabled
    if (_decodeURL) {
      input = Uri.decodeComponent(input);
    }

    // Detect and decode based on enabled detection options
    Map<String, String> results = {};

    if (_detectUnicodeTags) {
      String decoded = _service.decodeUnicodeTags(input);
      if (decoded.isNotEmpty) {
        results['Unicode Tags'] = decoded;
      }
    }

    if (_detectVariantSelectors) {
      String decoded = _service.decodeVariantSelectors(input);
      if (decoded != input && decoded.isNotEmpty) {
        results['Variant Selectors'] = decoded;
      }
    }

    if (_detectSneakyBits) {
      String decoded = _service.decodeSneakyBits(input);
      if (decoded.isNotEmpty) {
        results['Sneaky Bits'] = decoded;
      }
    }

    if (results.isEmpty) {
      _setStatus('No hidden text detected');
      setState(() {
        _outputController.text = 'No hidden text found';
      });
      return;
    }

    StringBuffer output = StringBuffer();
    output.writeln('Detected hidden text:\n');

    results.forEach((method, decoded) {
      output.writeln('[$method]');
      output.writeln(decoded);
      output.writeln();
    });

    setState(() {
      _outputController.text = output.toString();
      _updateDebugOutput(input);
      _updateStatistics(input);
      _setStatus('Decoded ${results.length} hidden message(s)');
    });
  }

  void _clear() {
    setState(() {
      _inputController.clear();
      _outputController.clear();
      _debugController.clear();
      _statistics = {};
      _setStatus('Cleared');
    });
  }

  void _updateDebugOutput(String text) {
    String debug = _service.getDebugOutput(text, format: _debugFormat);
    _debugController.text = debug;
  }

  void _updateStatistics(String text) {
    _statistics = _service.getStatistics(text);
  }

  void _setStatus(String message) {
    setState(() {
      _statusMessage = message;
    });

    // Clear status after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted && _statusMessage == message) {
        setState(() {
          _statusMessage = '';
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ASCII Smuggler'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => InfoDialog.show(context),
            tooltip: 'About',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Description
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Convert text to invisible Unicode encodings and decode hidden secrets',
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Input area
            TextField(
              controller: _inputController,
              decoration: const InputDecoration(
                labelText: 'Input Text',
                hintText: 'Enter text to encode or decode...',
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
              onChanged: (text) {
                setState(() {});
                if (_autoDecodeEnabled && text.isNotEmpty) {
                  _decode();
                }
              },
            ),
            const SizedBox(height: 16),

            // Action buttons
            ActionButtons(
              onEncode: _encode,
              onDecode: _decode,
              onClear: _clear,
            ),
            const SizedBox(height: 16),

            // Toggle Advanced Options
            Center(
              child: TextButton(
                onPressed: () => setState(() => _showAdvancedOptions = !_showAdvancedOptions),
                child: Text(_showAdvancedOptions ? 'Hide Advanced Options' : 'Toggle Advanced Options'),
              ),
            ),
            const SizedBox(height: 8),

            // Advanced options (encoding, decoding, detection)
            if (_showAdvancedOptions)
              AdvancedOptionsSection(
                encodingMode: _encodingMode,
                addBeginEndTags: _addBeginEndTags,
                onEncodingModeChanged: (value) => setState(() => _encodingMode = value),
                onAddBeginEndTagsChanged: (value) => setState(() => _addBeginEndTags = value),
                decodeURL: _decodeURL,
                highlightMode: _highlightMode,
                autoDecodeEnabled: _autoDecodeEnabled,
                showDebugEnabled: _showDebugEnabled,
                onDecodeURLChanged: (value) => setState(() => _decodeURL = value),
                onHighlightModeChanged: (value) => setState(() => _highlightMode = value),
                onAutoDecodeChanged: (value) => setState(() => _autoDecodeEnabled = value),
                onShowDebugChanged: (value) => setState(() => _showDebugEnabled = value),
                detectUnicodeTags: _detectUnicodeTags,
                detectVariantSelectors: _detectVariantSelectors,
                detectOtherInvisible: _detectOtherInvisible,
                detectSneakyBits: _detectSneakyBits,
                onDetectUnicodeTagsChanged: (value) => setState(() => _detectUnicodeTags = value),
                onDetectVariantSelectorsChanged: (value) => setState(() => _detectVariantSelectors = value),
                onDetectOtherInvisibleChanged: (value) => setState(() => _detectOtherInvisible = value),
                onDetectSneakyBitsChanged: (value) => setState(() => _detectSneakyBits = value),
              ),
            if (_showAdvancedOptions) const SizedBox(height: 16),

            // Input Options (Quick insert characters)
            if (_showAdvancedOptions)
              InputOptionsSection(
                onStatusUpdate: _setStatus,
              ),
            if (_showAdvancedOptions) const SizedBox(height: 16),
            const SizedBox(height: 16),

            // Status message
            if (_statusMessage.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _statusMessage,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
              ),
            if (_statusMessage.isNotEmpty) const SizedBox(height: 16),

            // Output area with visual indicator for invisible characters
            Stack(
              children: [
                TextField(
                  controller: _outputController,
                  decoration: InputDecoration(
                    labelText: 'Output',
                    border: const OutlineInputBorder(),
                    helperText: _outputController.text.isNotEmpty && _statistics['invisible'] != null && _statistics['invisible']! > 0
                        ? 'Contains ${_statistics['invisible']} invisible characters - Click Copy to use'
                        : null,
                    helperMaxLines: 2,
                    filled: _outputController.text.isNotEmpty,
                    fillColor: _outputController.text.isNotEmpty
                        ? Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3)
                        : null,
                  ),
                  maxLines: 5,
                  readOnly: true,
                  style: const TextStyle(fontFamily: 'monospace'),
                ),
                // Show visual placeholder when output contains only invisible characters
                if (_outputController.text.isNotEmpty &&
                    _statistics['visible'] != null &&
                    _statistics['visible'] == 0 &&
                    _statistics['invisible'] != null &&
                    _statistics['invisible']! > 0)
                  Positioned(
                    left: 12,
                    top: 12,
                    child: Text(
                      '[${_statistics['invisible']} invisible characters - see Debug Output below]',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.5),
                        fontStyle: FontStyle.italic,
                        fontSize: 12,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),

            // Statistics
            if (_statistics.isNotEmpty)
              StatisticsSection(
                statistics: _statistics,
              ),
            if (_statistics.isNotEmpty) const SizedBox(height: 16),

            // Debug output (only show if enabled)
            if (_showDebugEnabled)
              DebugSection(
                debugController: _debugController,
                debugFormat: _debugFormat,
                onDebugFormatChanged: (value) {
                  setState(() {
                    _debugFormat = value;
                    if (_outputController.text.isNotEmpty) {
                      _updateDebugOutput(_outputController.text);
                    }
                  });
                },
              ),
            if (_showDebugEnabled) const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
