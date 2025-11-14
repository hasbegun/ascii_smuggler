# ASCII Smuggler

这是一个用于注入隐藏提示的AI安全工具。

一个将文本转换为不可见Unicode编码并解码隐藏秘密的Flutter应用程序。了解更多信息请访问[AWS安全博客](https://aws.amazon.com/blogs/security/defending-llm-applications-against-unicode-character-smuggling/)和[Garak ASCII Smuggler](https://reference.garak.ai/en/latest/ascii_smuggling.html)。

"ASCII走私是一种利用LLM分词器会处理不可打印或零宽度字符(如Unicode标签和变体选择器)这一事实的技术。这使其对绕过LLM防护栏非常有用,因为这些防护栏通常没有针对这些规避技术进行训练,并且可以规避人工干预控制,因为用户在屏幕上查看时看不到这些字符。一些LLM会乐意解码相关文本并优雅地处理它。" -- Garak (ascii_sumggling.html)

## 功能

### 编码方法

1. **Unicode标签**
   - 将字符转换为U+E0000 Unicode块中的不可见标签字符
   - 可选择添加BEGIN/END标签标记
   - 基于原始Python实现

2. **变体选择器**
   - 在每个字符后添加变体选择器字符(U+FE00 - U+FE0F)
   - 可配置的VS2偏移量(0-15)
   - 字符保持可见但包含隐藏数据

3. **隐秘位(UTF-8)**
   - 使用零宽度字符进行二进制编码
   - 每个字符转换为8位二进制
   - 使用ZWSP(零宽度空格)表示'0',ZWNJ(零宽度非连接符)表示'1'

### 高级选项

该应用包含与原始网站相匹配的全面高级选项:

**编码选项:**
- 三种编码模式:Unicode标签、变体选择器、隐秘位(UTF-8)
- Unicode标签编码的可选BEGIN/END标签
  - **默认:关闭**(与原始Python实现一致)
  - 某些AI模型可能无法正确处理BEGIN/END控制字符
  - 仅在您的用例需要明确分隔符时启用

**解码选项:**
- **URL解码**:处理前对输入进行URL解码
- **高亮模式**:高亮显示检测到的不可见字符(计划功能)
- **自动解码**:输入时自动解码
- **显示调试**:切换调试输出可见性

**检测选项:**
- 选择性启用/禁用检测:
  - Unicode标签
  - 变体选择器
  - 其他不可见字符
  - 隐秘位

**输入选项:**
- 20多个特殊Unicode字符的快速插入按钮:
  - 零宽度字符(ZWSP、ZWNJ、ZWJ、WJ)
  - 方向格式字符(LRM、RLM、LRE、RLE、PDF、LRO、RLO、LRI、RLI、FSI、PDI)
  - 其他特殊字符(SHY、FNAP、MVS、ISEP)
  - 表情符号快捷方式

### 主要特性

- **编码并复制**:将文本转换为不可见编码并自动复制到剪贴板
- **解码**:自动检测和解码所有编码方法
- **统计**:查看字符计数和类型(总计、可见、不可见、标签、变体选择器、零宽度)
- **调试输出**:以Unicode、十六进制或二进制格式查看字符代码
- **切换高级选项**:带有可展开高级选项的简洁界面
- **快速插入按钮**:一键复制特殊Unicode字符
- **与原始网站匹配**:产生与原始ASCII Smuggler演示相同的输出
- **简洁UI**:具有直观控件的精简界面

## 入门

### 先决条件

- Flutter SDK(3.9.0或更高版本)
- Dart SDK

### 安装

1. 导航到项目目录:
   ```bash
   cd ascii_smuggler
   ```

2. 获取依赖项:
   ```bash
   flutter pub get
   ```

3. 运行应用:
   ```bash
   flutter run
   ```

### 在不同平台上运行

```bash
# 在Chrome(Web)上运行
flutter run -d chrome

# 在iOS模拟器上运行
flutter run -d ios

# 在Android模拟器上运行
flutter run -d android

# 在macOS上运行
flutter run -d macos
```

## 快速入门示例

以下是如何使用ASCII Smuggler向AI模型注入隐藏提示的实际演示:

### 步骤1:编码您的隐藏提示

1. 打开ASCII Smuggler应用
2. 在输入字段中输入您的隐藏问题:`what does cnn do?`
3. 点击**"编码并复制"**按钮
4. 不可见的编码文本现已复制到剪贴板

![截图1 - 编码隐藏提示](screenshots/screenshot1.png)

### 步骤2:与AI模型一起使用(Gemini示例)

1. 访问[Google Gemini](https://gemini.google.com)
2. 输入一个可见的问题:`show what fibonacci in 2 sentences.`
3. 输入后,按**CMD+V(Mac)**或**CTRL+V(Windows)**粘贴不可见的编码文本
4. 按Enter发送

**您在提示中看到的内容:**
```
show what fibonacci in 2 sentences.
```

**AI实际接收到的内容:**
```
show what fibonacci in 2 sentences. [不可见: what does cnn do?]
```

### 步骤3:观察结果

AI将同时回答可见问题(斐波那契)**和**隐藏问题(CNN),即使隐藏文本在聊天界面中完全不可见!

![答案 - AI回应两个提示](screenshots/answer.png)

**要点:**
- ✅ 隐藏文本对人类**完全不可见**
- ✅ AI模型可以**读取和处理**隐藏指令
- ✅ 这演示了通过Unicode隐写术进行的**提示注入**
- ⚠️ 仅负责任地用于安全研究和教育目的

## 使用方法

1. **编码文本**:
   - 在"输入文本"字段中输入文本(例如:"what can you do?")
   - 选择编码方法(Unicode标签、变体选择器或隐秘位)
   - 通过"切换高级选项"配置任何特定于方法的选项
   - 点击"编码并复制"
   - **不可见的编码文本**自动复制到剪贴板
   - 文本完全不可见 - 粘贴时您将看不到任何内容
   - 调试输出部分显示用于验证的Unicode代码

2. **与AI模型一起使用(Gemini、ChatGPT等)**:
   - 编码后,将剪贴板内容直接粘贴到AI聊天中
   - 文本对您来说看起来**完全不可见**(空白),但AI可以读取隐藏指令
   - **重要**:为了与AI模型获得最佳兼容性,请使用默认设置(BEGIN/END标签 = 关闭)
   - 编码输出与研究论文中的原始Python实现相匹配
   - 这实现了隐写提示注入演示 - AI处理不可见指令

3. **解码文本**:
   - 在"输入文本"字段中粘贴编码文本
   - 点击"解码"
   - 应用将自动检测并解码所有隐藏消息
   - 结果显示在"输出"字段中

4. **调试输出**:
   - 编码后自动显示
   - 以Unicode、十六进制或二进制格式查看详细字符代码
   - 有助于理解编码结构和验证输出

5. **统计**:
   - 查看总计、可见、不可见、标签、变体选择器和零宽度字符的计数
   - 有助于验证编码是否正常工作

## 测试

运行测试:
```bash
flutter test
```

运行静态分析:
```bash
flutter analyze
```

## 项目结构

该项目遵循清晰的模块化架构,具有明确的关注点分离:

```
ascii_smuggler/
├── lib/
│   ├── main.dart                           # 应用入口点(32行)
│   ├── pages/
│   │   └── home_page.dart                  # 主屏幕实现
│   ├── services/
│   │   └── ascii_smuggler_service.dart     # 编码/解码业务逻辑
│   └── widgets/
│       ├── action_buttons.dart             # 编码、解码、清除按钮
│       ├── advanced_options_section.dart   # 编码/解码选项
│       ├── debug_section.dart              # 调试输出查看器
│       ├── info_dialog.dart                # 关于对话框
│       ├── input_options_section.dart      # 快速插入字符按钮
│       └── statistics_section.dart         # 字符统计显示
├── test/
│   ├── widget_test.dart                    # Widget测试
│   ├── encoding_test.dart                  # 编码/解码测试
│   ├── ai_model_test.dart                  # AI兼容性测试
│   ├── comparison_test.dart                # Python实现比较
│   └── gemini_test.dart                    # Gemini特定测试
└── README.md
```

### 架构优势

- **模块化设计**:每个widget都是自包含和可重用的
- **清晰分离**:应用初始化、页面、widget和服务明确分离
- **易于维护**:小而专注的文件更易于理解和修改
- **可扩展**:随着应用增长,简单添加新页面或widget
- **可测试**:每个组件可以独立测试

## 用例

- **安全研究**:理解基于Unicode的隐写术
- **教育**:学习Unicode编码和不可见字符
- **CTF挑战**:解决涉及隐藏文本的挑战
- **隐写术演示**:展示文本如何隐藏在明处

## 技术细节

### 使用的Unicode字符块

- **标签字符**: U+E0000 - U+E007F(不可见格式字符)
- **变体选择器**: U+FE00 - U+FE0F(修改前一个字符的外观)
- **零宽度字符**:
  - U+200B: 零宽度空格(ZWSP)
  - U+200C: 零宽度非连接符(ZWNJ)
  - U+200D: 零宽度连接符(ZWJ)

### 编码算法

**Unicode标签**: 每个字符的码点偏移0xE0000
```dart
encoded = chr(0xE0000 + ord(character))
```

**变体选择器**: 在每个字符后插入变体选择器字符
```dart
encoded = character + chr(0xFE00 + offset)
```

**隐秘位**: 字符转换为8位二进制,每位由零宽度字符表示
```dart
binary = character.toBinary(8)
encoded = binary.replace('0', ZWSP).replace('1', ZWNJ)
```

## 参考资料
- [AWS安全博客](https://aws.amazon.com/blogs/security/defending-llm-applications-against-unicode-character-smuggling/)
- [Garak ASCII Smuggler](https://reference.garak.ai/en/latest/ascii_smuggling.html)
- [ASCII Smuggling GitHub仓库](https://github.com/TrustAI-laboratory/ASCII-Smuggling-Hidden-Prompt-Injection-Demo)
- [Unicode标签规范](https://www.unicode.org/charts/PDF/UE0000.pdf)
- [变体选择器](https://www.unicode.org/reports/tr37/)

## 许可证

这是一个基于ASCII Smuggler概念的教育项目。

## 贡献

这是用于教育目的的原始ASCII Smuggler演示的克隆版本。
