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
  bool _addBeginEndTags = true;
  int _vs2Offset = 16;
  final String _zeroChar = '\u200B'; // ZWSP
  final String _oneChar = '\u200C'; // ZWNJ

  // Debug options
  String _debugFormat = 'unicode';

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
      _setStatus('Text encoded successfully');
    });
  }

  void _decode() {
    String input = _inputController.text;
    if (input.isEmpty) {
      _setStatus('Please enter text to decode');
      return;
    }

    Map<String, String> results = _service.detectAndDecode(input);

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
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 16),

            // Encoding mode selection
            _buildEncodingModeSection(),
            const SizedBox(height: 16),

            // Action buttons
            _buildActionButtons(),
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

            // Output area
            TextField(
              controller: _outputController,
              decoration: const InputDecoration(
                labelText: 'Output',
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
              readOnly: true,
              style: const TextStyle(fontFamily: 'monospace'),
            ),
            const SizedBox(height: 16),

            // Statistics
            if (_statistics.isNotEmpty) _buildStatisticsSection(),
            if (_statistics.isNotEmpty) const SizedBox(height: 16),

            // Debug output
            _buildDebugSection(),
            const SizedBox(height: 16),

            // Quick insert characters
            _buildQuickInsertSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildEncodingModeSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Encoding Strategy',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            ListTile(
              title: const Text('Unicode Tags'),
              subtitle: const Text('Use invisible tag characters (U+E0000)'),
              leading: Radio<EncodingMode>(
                value: EncodingMode.unicodeTags,
                groupValue: _encodingMode,
                onChanged: (value) => setState(() => _encodingMode = value!),
              ),
              onTap: () => setState(() => _encodingMode = EncodingMode.unicodeTags),
            ),
            if (_encodingMode == EncodingMode.unicodeTags)
              Padding(
                padding: const EdgeInsets.only(left: 32.0),
                child: CheckboxListTile(
                  title: const Text('Add BEGIN/END Tags'),
                  value: _addBeginEndTags,
                  onChanged: (value) => setState(() => _addBeginEndTags = value!),
                  dense: true,
                ),
              ),
            ListTile(
              title: const Text('Variant Selectors'),
              subtitle: const Text('Use variant selector characters'),
              leading: Radio<EncodingMode>(
                value: EncodingMode.variantSelectors,
                groupValue: _encodingMode,
                onChanged: (value) => setState(() => _encodingMode = value!),
              ),
              onTap: () => setState(() => _encodingMode = EncodingMode.variantSelectors),
            ),
            if (_encodingMode == EncodingMode.variantSelectors)
              Padding(
                padding: const EdgeInsets.only(left: 32.0),
                child: Row(
                  children: [
                    const Text('VS2 Offset: '),
                    SizedBox(
                      width: 100,
                      child: TextField(
                        decoration: const InputDecoration(
                          hintText: '16',
                          isDense: true,
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          int? offset = int.tryParse(value);
                          if (offset != null && offset >= 0 && offset <= 15) {
                            setState(() => _vs2Offset = offset);
                          }
                        },
                        controller: TextEditingController(text: _vs2Offset.toString()),
                      ),
                    ),
                  ],
                ),
              ),
            ListTile(
              title: const Text('Sneaky Bits (UTF-8)'),
              subtitle: const Text('Binary encoding with invisible chars'),
              leading: Radio<EncodingMode>(
                value: EncodingMode.sneakyBits,
                groupValue: _encodingMode,
                onChanged: (value) => setState(() => _encodingMode = value!),
              ),
              onTap: () => setState(() => _encodingMode = EncodingMode.sneakyBits),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: _encode,
            icon: const Icon(Icons.lock),
            label: const Text('Encode'),
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

  Widget _buildQuickInsertSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Quick Insert Characters',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildQuickInsertButton('ZWSP', '\u200B', 'Zero Width Space'),
                _buildQuickInsertButton('ZWNJ', '\u200C', 'Zero Width Non-Joiner'),
                _buildQuickInsertButton('ZWJ', '\u200D', 'Zero Width Joiner'),
                _buildQuickInsertButton('VS1', '\uFE00', 'Variant Selector 1'),
                _buildQuickInsertButton('VS2', '\uFE01', 'Variant Selector 2'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickInsertButton(String label, String char, String tooltip) {
    return ElevatedButton(
      onPressed: () {
        Clipboard.setData(ClipboardData(text: char));
        _setStatus('Copied $label to clipboard');
      },
      child: Text(label),
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
