// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appTitle => 'ASCII 스머글러';

  @override
  String get appDescription => '텍스트를 보이지 않는 유니코드 인코딩으로 변환하고 숨겨진 비밀을 해독합니다';

  @override
  String get inputLabel => '입력 텍스트';

  @override
  String get inputHint => '인코딩 또는 디코딩할 텍스트를 입력하세요...';

  @override
  String get encodeAndCopy => '인코딩 & 복사';

  @override
  String get decode => '디코딩';

  @override
  String get clear => '지우기';

  @override
  String get hideAdvancedOptions => '고급 옵션 숨기기';

  @override
  String get toggleAdvancedOptions => '고급 옵션 전환';

  @override
  String get output => '출력';

  @override
  String containsInvisibleCharsHelper(int count) {
    return '$count개의 보이지 않는 문자 포함 - 복사를 클릭하여 사용';
  }

  @override
  String invisibleCharsDebugPlaceholder(int count) {
    return '[$count개의 보이지 않는 문자 - 아래 디버그 출력 참조]';
  }

  @override
  String get encodingOptions => '인코딩 옵션';

  @override
  String get decodingOptions => '디코딩 옵션';

  @override
  String get unicodeTags => '유니코드 태그';

  @override
  String get variantSelectors => '변형 선택자';

  @override
  String get sneakyBitsUtf8 => 'Sneaky Bits (UTF-8)';

  @override
  String get addBeginEndTags => 'BEGIN/END 태그 추가';

  @override
  String get decodeUrl => 'URL 디코딩';

  @override
  String get highlightMode => '하이라이트 모드';

  @override
  String get autoDecode => '자동 디코딩';

  @override
  String get showDebug => '디버그 표시';

  @override
  String get otherInvisible => '기타 보이지 않는 문자';

  @override
  String get sneakyBits => 'Sneaky Bits';

  @override
  String get inputOptions => '입력 옵션';

  @override
  String get inputOptionsDescription => '버튼을 클릭하여 문자를 클립보드에 복사합니다.';

  @override
  String get statistics => '통계';

  @override
  String get total => '전체';

  @override
  String get visible => '보이는 문자';

  @override
  String get invisible => '보이지 않는 문자';

  @override
  String get tags => '태그';

  @override
  String get zeroWidth => '제로 너비';

  @override
  String get debugOutput => '디버그 출력';

  @override
  String get unicode => '유니코드';

  @override
  String get hexadecimal => '16진수';

  @override
  String get binary => '2진수';

  @override
  String get debugHint => '문자 코드가 여기에 표시됩니다...';

  @override
  String get aboutAsciiSmuggler => 'ASCII 스머글러 정보';

  @override
  String get aboutDescription =>
      'ASCII 스머글러는 텍스트를 보이지 않는 유니코드 인코딩으로 변환하고 숨겨진 비밀을 해독합니다.';

  @override
  String get encodingMethods => '인코딩 방법:';

  @override
  String get unicodeTagsDescription =>
      '• 유니코드 태그: 보이지 않는 태그 문자 사용 (U+E0000 블록)';

  @override
  String get variantSelectorsDescription => '• 변형 선택자: 변형 선택자 문자 추가';

  @override
  String get sneakyBitsDescription => '• Sneaky Bits: 제로 너비 문자를 사용한 바이너리 인코딩';

  @override
  String get useCases => '사용 사례:';

  @override
  String get useCaseSecurityResearch => '• 보안 연구';

  @override
  String get useCaseSteganography => '• 스테가노그래피 시연';

  @override
  String get useCaseUnicodeEncoding => '• 유니코드 인코딩 이해';

  @override
  String get close => '닫기';

  @override
  String get about => '정보';

  @override
  String get pleaseEnterTextToEncode => '인코딩할 텍스트를 입력하세요';

  @override
  String get pleaseEnterTextToDecode => '디코딩할 텍스트를 입력하세요';

  @override
  String get textCopiedToClipboard => '텍스트가 클립보드에 복사되었습니다!';

  @override
  String get noHiddenTextDetected => '숨겨진 텍스트가 감지되지 않았습니다';

  @override
  String get noHiddenTextFound => '숨겨진 텍스트를 찾을 수 없습니다';

  @override
  String get detectedHiddenText => '감지된 숨겨진 텍스트:\\n';

  @override
  String decodedMessages(int count) {
    return '$count개의 숨겨진 메시지를 디코딩했습니다';
  }

  @override
  String get cleared => '지워졌습니다';

  @override
  String copiedToClipboard(String label) {
    return '$label을(를) 클립보드에 복사했습니다';
  }
}
