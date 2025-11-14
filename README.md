# ASCII Smuggler

A Flutter application that converts text to invisible Unicode encodings and decodes hidden secrets. This is a clone of the [ASCII Smuggler demo website](https://embracethered.com/blog/ascii-smuggler.html).

## Features

### Encoding Methods

1. **Unicode Tags**
   - Converts characters to invisible tag characters in the U+E0000 Unicode block
   - Option to add BEGIN/END tag markers
   - Based on the original Python implementation

2. **Variant Selectors**
   - Adds variant selector characters (U+FE00 - U+FE0F) after each character
   - Configurable VS2 offset (0-15)
   - Characters remain visible but contain hidden data

3. **Sneaky Bits (UTF-8)**
   - Binary encoding using zero-width characters
   - Each character converted to 8-bit binary
   - Uses ZWSP (Zero Width Space) for '0' and ZWNJ (Zero Width Non-Joiner) for '1'

### Advanced Options

The app includes comprehensive advanced options matching the original website:

**Encoding Options:**
- Three encoding modes: Unicode Tags, Variant Selectors, Sneaky Bits (UTF-8)
- Optional BEGIN/END tags for Unicode Tags encoding
  - **Default: OFF** (matches original Python implementation)
  - Some AI models may not process BEGIN/END control characters correctly
  - Enable only if you need explicit delimiters for your use case

**Decoding Options:**
- **Decode URL**: URL-decode input before processing
- **Highlight Mode**: Highlight detected invisible characters (planned feature)
- **Auto-decode**: Automatically decode as you type
- **Show Debug**: Toggle debug output visibility

**Detection Options:**
- Selectively enable/disable detection for:
  - Unicode Tags
  - Variant Selectors
  - Other Invisible characters
  - Sneaky Bits

**Input Options:**
- Quick insert buttons for 20+ special Unicode characters:
  - Zero-width characters (ZWSP, ZWNJ, ZWJ, WJ)
  - Directional formatting (LRM, RLM, LRE, RLE, PDF, LRO, RLO, LRI, RLI, FSI, PDI)
  - Other special characters (SHY, FNAP, MVS, ISEP)
  - Emoji shortcuts

### Key Features

- **Encode & Decode**: Convert between visible and hidden text
- **Copy to Clipboard**: Easy copying of encoded/decoded results
- **Statistics**: View character counts and types (total, visible, invisible, tags, variant selectors, zero-width)
- **Debug Output**: View character codes in Unicode, Hex, or Binary format
- **Toggle Advanced Options**: Clean interface with expandable advanced options
- **Auto-Detection**: Automatically detects and decodes all encoding methods
- **Matches Original Website**: Produces identical output to the original ASCII Smuggler demo

## Getting Started

### Prerequisites

- Flutter SDK (3.9.0 or higher)
- Dart SDK

### Installation

1. Navigate to the project directory:
   ```bash
   cd ascii_smuggler
   ```

2. Get dependencies:
   ```bash
   flutter pub get
   ```

3. Run the app:
   ```bash
   flutter run
   ```

### Running on Different Platforms

```bash
# Run on Chrome (Web)
flutter run -d chrome

# Run on iOS Simulator
flutter run -d ios

# Run on Android Emulator
flutter run -d android

# Run on macOS
flutter run -d macos
```

## Usage

1. **To Encode Text**:
   - Enter your text in the "Input Text" field (e.g., "what can you do?")
   - Select an encoding method (Unicode Tags, Variant Selectors, or Sneaky Bits)
   - Configure any method-specific options via "Toggle Advanced Options"
   - Click "Encode & Copy"
   - The **invisible encoded text** is automatically copied to clipboard
   - The text is completely invisible - you'll see nothing when you paste it
   - The Debug Output section shows the Unicode codes for verification

2. **Using with AI Models (Gemini, ChatGPT, etc.)**:
   - After encoding, paste the clipboard content directly into the AI chat
   - The text appears **completely invisible** (blank) to you, but the AI can read the hidden instructions
   - **IMPORTANT**: For best compatibility with AI models, use the default setting (BEGIN/END Tags = OFF)
   - The encoded output matches the original Python implementation from the research paper
   - This enables steganographic prompt injection demonstrations - the AI processes invisible instructions

3. **To Decode Text**:
   - Paste encoded text in the "Input Text" field
   - Click "Decode"
   - The app will automatically detect and decode all hidden messages
   - Results are shown in the "Output" field

4. **Debug Output**:
   - Automatically shown after encoding
   - View detailed character codes in Unicode, Hexadecimal, or Binary format
   - Helpful for understanding the encoding structure and verifying output

5. **Statistics**:
   - See counts of total, visible, invisible, tag, variant selector, and zero-width characters
   - Helps verify the encoding worked correctly

## Testing

Run the tests:
```bash
flutter test
```

Run static analysis:
```bash
flutter analyze
```

## Project Structure

```
ascii_smuggler/
├── lib/
│   ├── main.dart                      # Main app UI
│   └── services/
│       └── ascii_smuggler_service.dart # Encoding/decoding logic
├── test/
│   └── widget_test.dart               # Widget tests
└── README.md
```

## Use Cases

- **Security Research**: Understand Unicode-based steganography
- **Educational**: Learn about Unicode encoding and invisible characters
- **CTF Challenges**: Solve challenges involving hidden text
- **Steganography Demonstrations**: Show how text can be hidden in plain sight

## Technical Details

### Unicode Character Blocks Used

- **Tag Characters**: U+E0000 - U+E007F (invisible formatting characters)
- **Variant Selectors**: U+FE00 - U+FE0F (modify appearance of preceding character)
- **Zero-Width Characters**:
  - U+200B: Zero Width Space (ZWSP)
  - U+200C: Zero Width Non-Joiner (ZWNJ)
  - U+200D: Zero Width Joiner (ZWJ)

### Encoding Algorithms

**Unicode Tags**: Each character's codepoint is offset by 0xE0000
```dart
encoded = chr(0xE0000 + ord(character))
```

**Variant Selectors**: Variant selector character inserted after each character
```dart
encoded = character + chr(0xFE00 + offset)
```

**Sneaky Bits**: Character converted to 8-bit binary, each bit represented by a zero-width character
```dart
binary = character.toBinary(8)
encoded = binary.replace('0', ZWSP).replace('1', ZWNJ)
```

## References

- [Original ASCII Smuggler Demo](https://embracethered.com/blog/ascii-smuggler.html)
- [ASCII Smuggling GitHub Repo](https://github.com/TrustAI-laboratory/ASCII-Smuggling-Hidden-Prompt-Injection-Demo)
- [Unicode Tags Specification](https://www.unicode.org/charts/PDF/UE0000.pdf)
- [Variant Selectors](https://www.unicode.org/reports/tr37/)

## License

This is an educational project based on the ASCII Smuggler concept.

## Contributing

This is a clone of the original ASCII Smuggler demo for educational purposes.
