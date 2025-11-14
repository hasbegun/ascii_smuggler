// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'ASCIIスマグラー';

  @override
  String get appDescription => 'テキストを不可視のUnicodeエンコーディングに変換し、隠された秘密を解読します';

  @override
  String get inputLabel => '入力テキスト';

  @override
  String get inputHint => 'エンコードまたはデコードするテキストを入力...';

  @override
  String get encodeAndCopy => 'エンコード & コピー';

  @override
  String get decode => 'デコード';

  @override
  String get clear => 'クリア';

  @override
  String get hideAdvancedOptions => '高度なオプションを非表示';

  @override
  String get toggleAdvancedOptions => '高度なオプション切り替え';

  @override
  String get output => '出力';

  @override
  String containsInvisibleCharsHelper(int count) {
    return '$count個の不可視文字が含まれています - コピーをクリックして使用';
  }

  @override
  String invisibleCharsDebugPlaceholder(int count) {
    return '[$count個の不可視文字 - 下のデバッグ出力を参照]';
  }

  @override
  String get encodingOptions => 'エンコードオプション';

  @override
  String get decodingOptions => 'デコードオプション';

  @override
  String get unicodeTags => 'Unicodeタグ';

  @override
  String get variantSelectors => 'バリアントセレクター';

  @override
  String get sneakyBitsUtf8 => 'Sneaky Bits (UTF-8)';

  @override
  String get addBeginEndTags => 'BEGIN/ENDタグを追加';

  @override
  String get decodeUrl => 'URLをデコード';

  @override
  String get highlightMode => 'ハイライトモード';

  @override
  String get autoDecode => '自動デコード';

  @override
  String get showDebug => 'デバッグ表示';

  @override
  String get otherInvisible => 'その他の不可視文字';

  @override
  String get sneakyBits => 'Sneaky Bits';

  @override
  String get inputOptions => '入力オプション';

  @override
  String get inputOptionsDescription => 'ボタンをクリックして文字をクリップボードにコピーします。';

  @override
  String get statistics => '統計';

  @override
  String get total => '合計';

  @override
  String get visible => '可視';

  @override
  String get invisible => '不可視';

  @override
  String get tags => 'タグ';

  @override
  String get zeroWidth => 'ゼロ幅';

  @override
  String get debugOutput => 'デバッグ出力';

  @override
  String get unicode => 'Unicode';

  @override
  String get hexadecimal => '16進数';

  @override
  String get binary => '2進数';

  @override
  String get debugHint => '文字コードがここに表示されます...';

  @override
  String get aboutAsciiSmuggler => 'ASCIIスマグラーについて';

  @override
  String get aboutDescription =>
      'ASCIIスマグラーはテキストを不可視のUnicodeエンコーディングに変換し、隠された秘密を解読します。';

  @override
  String get encodingMethods => 'エンコード方式：';

  @override
  String get unicodeTagsDescription => '• Unicodeタグ：不可視タグ文字を使用（U+E0000ブロック）';

  @override
  String get variantSelectorsDescription => '• バリアントセレクター：バリアントセレクター文字を追加';

  @override
  String get sneakyBitsDescription => '• Sneaky Bits：ゼロ幅文字を使用したバイナリエンコード';

  @override
  String get useCases => '使用例：';

  @override
  String get useCaseSecurityResearch => '• セキュリティ研究';

  @override
  String get useCaseSteganography => '• ステガノグラフィーのデモンストレーション';

  @override
  String get useCaseUnicodeEncoding => '• Unicodeエンコーディングの理解';

  @override
  String get close => '閉じる';

  @override
  String get about => 'について';

  @override
  String get pleaseEnterTextToEncode => 'エンコードするテキストを入力してください';

  @override
  String get pleaseEnterTextToDecode => 'デコードするテキストを入力してください';

  @override
  String get textCopiedToClipboard => 'テキストがクリップボードにコピーされました！';

  @override
  String get noHiddenTextDetected => '隠しテキストは検出されませんでした';

  @override
  String get noHiddenTextFound => '隠しテキストが見つかりません';

  @override
  String get detectedHiddenText => '検出された隠しテキスト：\\n';

  @override
  String decodedMessages(int count) {
    return '$count個の隠しメッセージをデコードしました';
  }

  @override
  String get cleared => 'クリアされました';

  @override
  String copiedToClipboard(String label) {
    return '$labelをクリップボードにコピーしました';
  }
}
