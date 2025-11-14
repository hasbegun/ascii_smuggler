// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'ASCII Smuggler';

  @override
  String get appDescription =>
      'Convierte texto a codificaciones Unicode invisibles y decodifica secretos ocultos';

  @override
  String get inputLabel => 'Texto de Entrada';

  @override
  String get inputHint => 'Ingrese texto para codificar o decodificar...';

  @override
  String get encodeAndCopy => 'Codificar y Copiar';

  @override
  String get decode => 'Decodificar';

  @override
  String get clear => 'Borrar';

  @override
  String get hideAdvancedOptions => 'Ocultar Opciones Avanzadas';

  @override
  String get toggleAdvancedOptions => 'Alternar Opciones Avanzadas';

  @override
  String get output => 'Salida';

  @override
  String containsInvisibleCharsHelper(int count) {
    return 'Contiene $count caracteres invisibles - Haga clic en Copiar para usar';
  }

  @override
  String invisibleCharsDebugPlaceholder(int count) {
    return '[$count caracteres invisibles - vea la Salida de Depuración abajo]';
  }

  @override
  String get encodingOptions => 'Opciones de Codificación';

  @override
  String get decodingOptions => 'Opciones de Decodificación';

  @override
  String get unicodeTags => 'Etiquetas Unicode';

  @override
  String get variantSelectors => 'Selectores de Variante';

  @override
  String get sneakyBitsUtf8 => 'Bits Furtivos (UTF-8)';

  @override
  String get addBeginEndTags => 'Agregar Etiquetas BEGIN/END';

  @override
  String get decodeUrl => 'Decodificar URL';

  @override
  String get highlightMode => 'Modo Resaltado';

  @override
  String get autoDecode => 'Decodificación Automática';

  @override
  String get showDebug => 'Mostrar Depuración';

  @override
  String get otherInvisible => 'Otros Invisibles';

  @override
  String get sneakyBits => 'Bits Furtivos';

  @override
  String get inputOptions => 'Opciones de Entrada';

  @override
  String get inputOptionsDescription =>
      'Haga clic en un botón para copiar el carácter al portapapeles.';

  @override
  String get statistics => 'Estadísticas';

  @override
  String get total => 'Total';

  @override
  String get visible => 'Visible';

  @override
  String get invisible => 'Invisible';

  @override
  String get tags => 'Etiquetas';

  @override
  String get zeroWidth => 'Ancho Cero';

  @override
  String get debugOutput => 'Salida de Depuración';

  @override
  String get unicode => 'Unicode';

  @override
  String get hexadecimal => 'Hexadecimal';

  @override
  String get binary => 'Binario';

  @override
  String get debugHint => 'Los códigos de caracteres aparecerán aquí...';

  @override
  String get aboutAsciiSmuggler => 'Acerca de ASCII Smuggler';

  @override
  String get aboutDescription =>
      'ASCII Smuggler convierte texto a codificaciones Unicode invisibles y decodifica secretos ocultos.';

  @override
  String get encodingMethods => 'Métodos de Codificación:';

  @override
  String get unicodeTagsDescription =>
      '• Etiquetas Unicode: Usa caracteres de etiqueta invisibles (bloque U+E0000)';

  @override
  String get variantSelectorsDescription =>
      '• Selectores de Variante: Agrega caracteres selectores de variante';

  @override
  String get sneakyBitsDescription =>
      '• Bits Furtivos: Codificación binaria con caracteres de ancho cero';

  @override
  String get useCases => 'Casos de Uso:';

  @override
  String get useCaseSecurityResearch => '• Investigación de seguridad';

  @override
  String get useCaseSteganography => '• Demostraciones de esteganografía';

  @override
  String get useCaseUnicodeEncoding => '• Comprensión de codificación Unicode';

  @override
  String get close => 'Cerrar';

  @override
  String get about => 'Acerca de';

  @override
  String get pleaseEnterTextToEncode =>
      'Por favor ingrese texto para codificar';

  @override
  String get pleaseEnterTextToDecode =>
      'Por favor ingrese texto para decodificar';

  @override
  String get textCopiedToClipboard => '¡Texto copiado al portapapeles!';

  @override
  String get noHiddenTextDetected => 'No se detectó texto oculto';

  @override
  String get noHiddenTextFound => 'No se encontró texto oculto';

  @override
  String get detectedHiddenText => 'Texto oculto detectado:\\n';

  @override
  String decodedMessages(int count) {
    return 'Decodificados $count mensaje(s) oculto(s)';
  }

  @override
  String get cleared => 'Borrado';

  @override
  String copiedToClipboard(String label) {
    return '$label copiado al portapapeles';
  }
}
