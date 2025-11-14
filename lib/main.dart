import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'services/ascii_smuggler_service.dart';

void main() {
  runApp(const AsciiSmugglerApp());
}

class AsciiSmugglerApp extends StatelessWidget {
  const AsciiSmugglerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ASCII Smuggler',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const AsciiSmugglerHomePage(),
    );
  }
}

class AsciiSmugglerHomePage extends StatefulWidget {
  const AsciiSmugglerHomePage({super.key});

  @override
  State<AsciiSmugglerHomePage> createState() => _AsciiSmugglerHomePageState();
}

enum EncodingMode {
  unicodeTags,
  variantSelectors,
  sneakyBits,
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

  void _copyToClipboard() {
    String text = _outputController.text;
    if (text.isEmpty) {
      _setStatus('Nothing to copy');
      return;
    }

    Clipboard.setData(ClipboardData(text: text));
    _setStatus('Copied to clipboard!');
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
            onPressed: () => _showInfoDialog(),
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
            _buildActionButtons(),
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
            if (_showAdvancedOptions) _buildAdvancedOptionsSection(),
            if (_showAdvancedOptions) const SizedBox(height: 16),

            // Input Options (Quick insert characters)
            if (_showAdvancedOptions) _buildInputOptionsSection(),
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
                        ? Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.3)
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
                        color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                        fontStyle: FontStyle.italic,
                        fontSize: 12,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),

            // Statistics
            if (_statistics.isNotEmpty) _buildStatisticsSection(),
            if (_statistics.isNotEmpty) const SizedBox(height: 16),

            // Debug output (only show if enabled)
            if (_showDebugEnabled) _buildDebugSection(),
            if (_showDebugEnabled) const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildAdvancedOptionsSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.cyan,
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
                    color: Colors.black,
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
              title: const Text('Add BEGIN/END Tags', style: TextStyle(color: Colors.black)),
              value: _addBeginEndTags,
              onChanged: (value) => setState(() => _addBeginEndTags = value!),
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
                    color: Colors.black,
                  ),
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildCheckboxOption('Decode URL', _decodeURL, (value) => setState(() => _decodeURL = value!)),
              _buildCheckboxOption('Highlight Mode', _highlightMode, (value) => setState(() => _highlightMode = value!)),
              _buildCheckboxOption('Auto-decode', _autoDecodeEnabled, (value) => setState(() => _autoDecodeEnabled = value!)),
              _buildCheckboxOption('Show Debug', _showDebugEnabled, (value) => setState(() => _showDebugEnabled = value!)),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildCheckboxOption('Unicode Tags', _detectUnicodeTags, (value) => setState(() => _detectUnicodeTags = value!)),
              _buildCheckboxOption('Variant Selectors', _detectVariantSelectors, (value) => setState(() => _detectVariantSelectors = value!)),
              _buildCheckboxOption('Other Invisible', _detectOtherInvisible, (value) => setState(() => _detectOtherInvisible = value!)),
              _buildCheckboxOption('Sneaky Bits', _detectSneakyBits, (value) => setState(() => _detectSneakyBits = value!)),
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
          groupValue: _encodingMode,
          onChanged: (value) => setState(() => _encodingMode = value!),
          fillColor: WidgetStateProperty.all(Colors.pink),
        ),
        Text(label, style: const TextStyle(color: Colors.black)),
      ],
    );
  }

  Widget _buildCheckboxOption(String label, bool value, void Function(bool?) onChanged) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
          fillColor: WidgetStateProperty.all(Colors.green),
        ),
        Text(label, style: const TextStyle(color: Colors.black)),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: _encode,
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
            onPressed: _decode,
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
            onPressed: _copyToClipboard,
            icon: const Icon(Icons.copy),
            label: const Text('Copy'),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.all(16),
            ),
          ),
        ),
        const SizedBox(width: 8),
        OutlinedButton.icon(
          onPressed: _clear,
          icon: const Icon(Icons.clear),
          label: const Text('Clear'),
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.all(16),
          ),
        ),
      ],
    );
  }

  Widget _buildStatisticsSection() {
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
                _buildStatChip('Total', _statistics['total'] ?? 0),
                _buildStatChip('Visible', _statistics['visible'] ?? 0),
                _buildStatChip('Invisible', _statistics['invisible'] ?? 0),
                _buildStatChip('Tags', _statistics['tags'] ?? 0),
                _buildStatChip('Variant Selectors', _statistics['variantSelectors'] ?? 0),
                _buildStatChip('Zero Width', _statistics['zeroWidth'] ?? 0),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatChip(String label, int count) {
    return Chip(
      label: Text('$label: $count'),
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
    );
  }

  Widget _buildDebugSection() {
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
                  value: _debugFormat,
                  items: const [
                    DropdownMenuItem(value: 'unicode', child: Text('Unicode')),
                    DropdownMenuItem(value: 'hex', child: Text('Hexadecimal')),
                    DropdownMenuItem(value: 'binary', child: Text('Binary')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _debugFormat = value!;
                      if (_outputController.text.isNotEmpty) {
                        _updateDebugOutput(_outputController.text);
                      }
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _debugController,
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

  Widget _buildInputOptionsSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.cyan,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'Input Options',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: Text(
              'Click a button to copy the character to clipboard.',
              style: TextStyle(color: Colors.black87, fontSize: 12),
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 4,
            runSpacing: 4,
            children: [
              _buildQuickInsertButton('ZWSP', '\u200B'),
              _buildQuickInsertButton('ZWNJ', '\u200C'),
              _buildQuickInsertButton('ZWJ', '\u200D'),
              _buildQuickInsertButton('WJ', '\u2060'), // Word Joiner
              _buildQuickInsertButton('×', '\u00D7'), // Multiplication sign
              _buildQuickInsertButton('+', '\u002B'), // Plus sign
              _buildQuickInsertButton('ISEP', '\u001F'), // Information Separator
              _buildQuickInsertButton('LRM', '\u200E'), // Left-to-Right Mark
              _buildQuickInsertButton('RLM', '\u200F'), // Right-to-Left Mark
              _buildQuickInsertButton('LRE', '\u202A'), // Left-to-Right Embedding
              _buildQuickInsertButton('RLE', '\u202B'), // Right-to-Left Embedding
              _buildQuickInsertButton('PDF', '\u202C'), // Pop Directional Formatting
              _buildQuickInsertButton('LRO', '\u202D'), // Left-to-Right Override
              _buildQuickInsertButton('RLO', '\u202E'), // Right-to-Left Override
              _buildQuickInsertButton('LRI', '\u2066'), // Left-to-Right Isolate
              _buildQuickInsertButton('RLI', '\u2067'), // Right-to-Left Isolate
              _buildQuickInsertButton('FSI', '\u2068'), // First Strong Isolate
              _buildQuickInsertButton('PDI', '\u2069'), // Pop Directional Isolate
              _buildQuickInsertButton('SHY', '\u00AD'), // Soft Hyphen
              _buildQuickInsertButton('FNAP', '\u180E'), // Mongolian Vowel Separator
              _buildQuickInsertButton('MVS', '\u180E'), // Mongolian Vowel Separator (duplicate)
              _buildQuickInsertButton('😊', '😊'), // Emoji
              _buildQuickInsertButton('🎉', '🎉'), // Emoji
              _buildQuickInsertButton('👍', '👍'), // Emoji
              _buildQuickInsertButton('⚠️', '⚠️'), // Emoji
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickInsertButton(String label, String char) {
    return ElevatedButton(
      onPressed: () {
        Clipboard.setData(ClipboardData(text: char));
        _setStatus('Copied $label to clipboard');
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

  void _showInfoDialog() {
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
