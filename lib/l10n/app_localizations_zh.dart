// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => 'ASCII走私者';

  @override
  String get appDescription => '将文本转换为不可见的Unicode编码并解码隐藏的秘密';

  @override
  String get inputLabel => '输入文本';

  @override
  String get inputHint => '输入要编码或解码的文本...';

  @override
  String get encodeAndCopy => '编码并复制';

  @override
  String get decode => '解码';

  @override
  String get clear => '清除';

  @override
  String get hideAdvancedOptions => '隐藏高级选项';

  @override
  String get toggleAdvancedOptions => '切换高级选项';

  @override
  String get output => '输出';

  @override
  String containsInvisibleCharsHelper(int count) {
    return '包含$count个不可见字符 - 点击复制使用';
  }

  @override
  String invisibleCharsDebugPlaceholder(int count) {
    return '[$count个不可见字符 - 请参阅下面的调试输出]';
  }

  @override
  String get encodingOptions => '编码选项';

  @override
  String get decodingOptions => '解码选项';

  @override
  String get unicodeTags => 'Unicode标签';

  @override
  String get variantSelectors => '变体选择器';

  @override
  String get sneakyBitsUtf8 => 'Sneaky Bits (UTF-8)';

  @override
  String get addBeginEndTags => '添加BEGIN/END标签';

  @override
  String get decodeUrl => '解码URL';

  @override
  String get highlightMode => '高亮模式';

  @override
  String get autoDecode => '自动解码';

  @override
  String get showDebug => '显示调试';

  @override
  String get otherInvisible => '其他不可见字符';

  @override
  String get sneakyBits => 'Sneaky Bits';

  @override
  String get inputOptions => '输入选项';

  @override
  String get inputOptionsDescription => '单击按钮将字符复制到剪贴板。';

  @override
  String get statistics => '统计';

  @override
  String get total => '总计';

  @override
  String get visible => '可见';

  @override
  String get invisible => '不可见';

  @override
  String get tags => '标签';

  @override
  String get zeroWidth => '零宽度';

  @override
  String get debugOutput => '调试输出';

  @override
  String get unicode => 'Unicode';

  @override
  String get hexadecimal => '十六进制';

  @override
  String get binary => '二进制';

  @override
  String get debugHint => '字符代码将显示在这里...';

  @override
  String get aboutAsciiSmuggler => '关于ASCII走私者';

  @override
  String get aboutDescription => 'ASCII走私者将文本转换为不可见的Unicode编码并解码隐藏的秘密。';

  @override
  String get encodingMethods => '编码方法：';

  @override
  String get unicodeTagsDescription => '• Unicode标签：使用不可见标签字符（U+E0000块）';

  @override
  String get variantSelectorsDescription => '• 变体选择器：添加变体选择器字符';

  @override
  String get sneakyBitsDescription => '• Sneaky Bits：使用零宽度字符的二进制编码';

  @override
  String get useCases => '使用案例：';

  @override
  String get useCaseSecurityResearch => '• 安全研究';

  @override
  String get useCaseSteganography => '• 隐写术演示';

  @override
  String get useCaseUnicodeEncoding => '• 理解Unicode编码';

  @override
  String get close => '关闭';

  @override
  String get about => '关于';

  @override
  String get pleaseEnterTextToEncode => '请输入要编码的文本';

  @override
  String get pleaseEnterTextToDecode => '请输入要解码的文本';

  @override
  String get textCopiedToClipboard => '文本已复制到剪贴板！';

  @override
  String get noHiddenTextDetected => '未检测到隐藏文本';

  @override
  String get noHiddenTextFound => '未找到隐藏文本';

  @override
  String get detectedHiddenText => '检测到的隐藏文本：\\n';

  @override
  String decodedMessages(int count) {
    return '已解码$count条隐藏消息';
  }

  @override
  String get cleared => '已清除';

  @override
  String copiedToClipboard(String label) {
    return '已将$label复制到剪贴板';
  }
}
