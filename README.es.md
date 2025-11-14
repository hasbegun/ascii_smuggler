# ASCII Smuggler

Esta es una herramienta de seguridad de IA para inyectar prompts ocultos.

Una aplicación Flutter que convierte texto a codificaciones Unicode invisibles y decodifica secretos ocultos. Obtenga más información en el [blog de AWS Security](https://aws.amazon.com/blogs/security/defending-llm-applications-against-unicode-character-smuggling/) y [Garak ASCII Smuggler](https://reference.garak.ai/en/latest/ascii_smuggling.html).

"El contrabando ASCII es una técnica que abusa del hecho de que los tokenizadores LLM manejarán caracteres no imprimibles o de ancho cero como etiquetas unicode y selectores de variantes. Esto lo hace útil para eludir las barreras de seguridad de LLM, que a menudo no están entrenadas en estas evasiones, y para eludir los controles de humano en el circuito, ya que los caracteres no serán visibles en la pantalla cuando los vean los usuarios. Algunos LLM decodificarán felizmente el texto relevante y lo manejarán con gracia." -- Garak (ascii_sumggling.html)

## Características

### Métodos de Codificación

1. **Etiquetas Unicode**
   - Convierte caracteres a caracteres de etiqueta invisibles en el bloque Unicode U+E0000
   - Opción para agregar marcadores de etiqueta BEGIN/END

2. **Selectores de Variantes**
   - Agrega caracteres de selector de variante (U+FE00 - U+FE0F) después de cada carácter
   - Offset VS2 configurable (0-15)
   - Los caracteres permanecen visibles pero contienen datos ocultos

3. **Bits Furtivos (UTF-8)**
   - Codificación binaria usando caracteres de ancho cero
   - Cada carácter convertido a binario de 8 bits
   - Usa ZWSP (Espacio de Ancho Cero) para '0' y ZWNJ (No Ensamblador de Ancho Cero) para '1'

### Opciones Avanzadas

La aplicación incluye opciones avanzadas completas que coinciden con el sitio web original:

**Opciones de Codificación:**
- Tres modos de codificación: Etiquetas Unicode, Selectores de Variantes, Bits Furtivos (UTF-8)
- Etiquetas BEGIN/END opcionales para codificación de Etiquetas Unicode
  - **Predeterminado: OFF** (coincide con la implementación original de Python)
  - Algunos modelos de IA pueden no procesar correctamente los caracteres de control BEGIN/END
  - Habilite solo si necesita delimitadores explícitos para su caso de uso

**Opciones de Decodificación:**
- **Decodificar URL**: Decodificar URL de entrada antes de procesar
- **Modo de Resaltado**: Resaltar caracteres invisibles detectados (función planificada)
- **Decodificación automática**: Decodificar automáticamente mientras escribe
- **Mostrar Depuración**: Alternar visibilidad de salida de depuración

**Opciones de Detección:**
- Habilitar/deshabilitar selectivamente detección para:
  - Etiquetas Unicode
  - Selectores de Variantes
  - Otros caracteres invisibles
  - Bits Furtivos

**Opciones de Entrada:**
- Botones de inserción rápida para más de 20 caracteres Unicode especiales:
  - Caracteres de ancho cero (ZWSP, ZWNJ, ZWJ, WJ)
  - Formato direccional (LRM, RLM, LRE, RLE, PDF, LRO, RLO, LRI, RLI, FSI, PDI)
  - Otros caracteres especiales (SHY, FNAP, MVS, ISEP)
  - Atajos de emoji

### Características Principales

- **Codificar y Copiar**: Convierte texto a codificaciones invisibles y copia automáticamente al portapapeles
- **Decodificar**: Detecta y decodifica automáticamente todos los métodos de codificación
- **Estadísticas**: Ver recuentos de caracteres y tipos (total, visible, invisible, etiquetas, selectores de variantes, ancho cero)
- **Salida de Depuración**: Ver códigos de caracteres en formato Unicode, Hexadecimal o Binario
- **Alternar Opciones Avanzadas**: Interfaz limpia con opciones avanzadas expandibles
- **Botones de Inserción Rápida**: Copiar caracteres Unicode especiales con un clic
- **Coincide con el Sitio Web Original**: Produce una salida idéntica a la demostración original de ASCII Smuggler
- **UI Limpia**: Interfaz optimizada con controles intuitivos

## Comenzando

### Requisitos Previos

- Flutter SDK (3.9.0 o superior)
- Dart SDK

### Instalación

1. Navegue al directorio del proyecto:
   ```bash
   cd ascii_smuggler
   ```

2. Obtenga las dependencias:
   ```bash
   flutter pub get
   ```

3. Ejecute la aplicación:
   ```bash
   flutter run
   ```

### Ejecutar en Diferentes Plataformas

```bash
# Ejecutar en Chrome (Web)
flutter run -d chrome

# Ejecutar en el Simulador iOS
flutter run -d ios

# Ejecutar en el Emulador Android
flutter run -d android

# Ejecutar en macOS
flutter run -d macos
```

## Ejemplo de Inicio Rápido

Aquí hay una demostración práctica de cómo usar ASCII Smuggler para inyectar prompts ocultos en modelos de IA:

### Paso 1: Codificar su Prompt Oculto

1. Abra la aplicación ASCII Smuggler
2. Ingrese su pregunta oculta en el campo de entrada: `what does cnn do?`
3. Haga clic en el botón **"Codificar y Copiar"**
4. El texto codificado invisible ahora está copiado en su portapapeles

![Captura de pantalla 1 - Codificando el prompt oculto](screenshots/screenshot1.png)

### Paso 2: Usar con Modelo de IA (Ejemplo de Gemini)

1. Vaya a [Google Gemini](https://gemini.google.com)
2. Escriba una pregunta visible: `show what fibonacci in 2 sentences.`
3. Después de escribir, presione **CMD+V (Mac)** o **CTRL+V (Windows)** para pegar el texto codificado invisible
4. Presione Enter para enviar

**Lo que ve en el prompt:**
```
show what fibonacci in 2 sentences.
```

**Lo que realmente recibe la IA:**
```
show what fibonacci in 2 sentences. [invisible: what does cnn do?]
```

### Paso 3: Observar el Resultado

¡La IA responderá **tanto** a la pregunta visible (Fibonacci) COMO a la pregunta oculta (CNN), aunque el texto oculto sea completamente invisible en la interfaz de chat!

![Respuesta - La IA responde a ambos prompts](screenshots/answer.png)

**Puntos Clave:**
- ✅ El texto oculto es **completamente invisible** para los humanos
- ✅ Los modelos de IA pueden **leer y procesar** las instrucciones ocultas
- ✅ Esto demuestra **inyección de prompt** a través de esteganografía Unicode
- ⚠️ Use responsablemente solo para investigación de seguridad y fines educativos

## Uso

1. **Para Codificar Texto**:
   - Ingrese su texto en el campo "Texto de Entrada" (ej., "what can you do?")
   - Seleccione un método de codificación (Etiquetas Unicode, Selectores de Variantes o Bits Furtivos)
   - Configure cualquier opción específica del método a través de "Alternar Opciones Avanzadas"
   - Haga clic en "Codificar y Copiar"
   - El **texto codificado invisible** se copia automáticamente al portapapeles
   - El texto es completamente invisible - no verá nada cuando lo pegue
   - La sección de Salida de Depuración muestra los códigos Unicode para verificación

2. **Usar con Modelos de IA (Gemini, ChatGPT, etc.)**:
   - Después de codificar, pegue el contenido del portapapeles directamente en el chat de IA
   - El texto aparece **completamente invisible** (en blanco) para usted, pero la IA puede leer las instrucciones ocultas
   - **IMPORTANTE**: Para una mejor compatibilidad con modelos de IA, use la configuración predeterminada (Etiquetas BEGIN/END = OFF)
   - La salida codificada coincide con la implementación original de Python del documento de investigación
   - Esto habilita demostraciones de inyección de prompt esteganográfico - la IA procesa instrucciones invisibles

3. **Para Decodificar Texto**:
   - Pegue texto codificado en el campo "Texto de Entrada"
   - Haga clic en "Decodificar"
   - La aplicación detectará y decodificará automáticamente todos los mensajes ocultos
   - Los resultados se muestran en el campo "Salida"

4. **Salida de Depuración**:
   - Se muestra automáticamente después de codificar
   - Ver códigos de caracteres detallados en formato Unicode, Hexadecimal o Binario
   - Útil para comprender la estructura de codificación y verificar la salida

5. **Estadísticas**:
   - Ver recuentos de caracteres totales, visibles, invisibles, de etiqueta, de selector de variante y de ancho cero
   - Ayuda a verificar que la codificación funcionó correctamente

## Pruebas

Ejecutar las pruebas:
```bash
flutter test
```

Ejecutar análisis estático:
```bash
flutter analyze
```

## Estructura del Proyecto

El proyecto sigue una arquitectura limpia y modular con una clara separación de preocupaciones:

```
ascii_smuggler/
├── lib/
│   ├── main.dart                           # Punto de entrada de la app (32 líneas)
│   ├── pages/
│   │   └── home_page.dart                  # Implementación de pantalla de inicio
│   ├── services/
│   │   └── ascii_smuggler_service.dart     # Lógica de negocio de codificación/decodificación
│   └── widgets/
│       ├── action_buttons.dart             # Botones Codificar, Decodificar, Limpiar
│       ├── advanced_options_section.dart   # Opciones de codificación/decodificación
│       ├── debug_section.dart              # Visor de salida de depuración
│       ├── info_dialog.dart                # Diálogo Acerca de
│       ├── input_options_section.dart      # Botones de inserción rápida de caracteres
│       └── statistics_section.dart         # Visualización de estadísticas de caracteres
├── test/
│   ├── widget_test.dart                    # Pruebas de widgets
│   ├── encoding_test.dart                  # Pruebas de codificación/decodificación
│   ├── ai_model_test.dart                  # Pruebas de compatibilidad con IA
│   ├── comparison_test.dart                # Comparación con implementación Python
│   └── gemini_test.dart                    # Pruebas específicas de Gemini
└── README.md
```

### Beneficios de la Arquitectura

- **Diseño Modular**: Cada widget es autónomo y reutilizable
- **Separación Clara**: La inicialización de la aplicación, páginas, widgets y servicios están claramente separados
- **Fácil Mantenimiento**: Los archivos pequeños y enfocados son más fáciles de entender y modificar
- **Escalable**: Sencillo agregar nuevas páginas o widgets a medida que la aplicación crece
- **Testeable**: Cada componente se puede probar de forma independiente

## Casos de Uso

- **Investigación de Seguridad**: Comprender la esteganografía basada en Unicode
- **Educativo**: Aprender sobre codificación Unicode y caracteres invisibles
- **Desafíos CTF**: Resolver desafíos que involucran texto oculto
- **Demostraciones de Esteganografía**: Mostrar cómo el texto puede ocultarse a simple vista

## Detalles Técnicos

### Bloques de Caracteres Unicode Utilizados

- **Caracteres de Etiqueta**: U+E0000 - U+E007F (caracteres de formato invisibles)
- **Selectores de Variantes**: U+FE00 - U+FE0F (modifican la apariencia del carácter anterior)
- **Caracteres de Ancho Cero**:
  - U+200B: Espacio de Ancho Cero (ZWSP)
  - U+200C: No Ensamblador de Ancho Cero (ZWNJ)
  - U+200D: Ensamblador de Ancho Cero (ZWJ)

### Algoritmos de Codificación

**Etiquetas Unicode**: El punto de código de cada carácter se desplaza en 0xE0000
```dart
encoded = chr(0xE0000 + ord(character))
```

**Selectores de Variantes**: Carácter de selector de variante insertado después de cada carácter
```dart
encoded = character + chr(0xFE00 + offset)
```

**Bits Furtivos**: Carácter convertido a binario de 8 bits, cada bit representado por un carácter de ancho cero
```dart
binary = character.toBinary(8)
encoded = binary.replace('0', ZWSP).replace('1', ZWNJ)
```

## Referencias
- [Blog de AWS Security](https://aws.amazon.com/blogs/security/defending-llm-applications-against-unicode-character-smuggling/)
- [Garak ASCII Smuggler](https://reference.garak.ai/en/latest/ascii_smuggling.html)
- [Repositorio GitHub de ASCII Smuggling](https://github.com/TrustAI-laboratory/ASCII-Smuggling-Hidden-Prompt-Injection-Demo)
- [Especificación de Etiquetas Unicode](https://www.unicode.org/charts/PDF/UE0000.pdf)
- [Selectores de Variantes](https://www.unicode.org/reports/tr37/)

## Licencia

Este es un proyecto educativo basado en el concepto de ASCII Smuggler.

## Contribuir

Este es un clon de la demostración original de ASCII Smuggler con fines educativos.
