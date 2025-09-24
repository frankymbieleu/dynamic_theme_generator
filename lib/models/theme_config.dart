import 'dart:convert';
import 'dart:io';

class ThemeConfig {
  final String name;
  final String className;
  final String outputDir;
  final ColorsConfig colors;
  final TypographyConfig typography;
  final ComponentsConfig components;
  final bool generateExample;

  ThemeConfig({
    required this.name,
    required this.className,
    required this.outputDir,
    required this.colors,
    required this.typography,
    required this.components,
    this.generateExample = false,
  });

  factory ThemeConfig.fromJson(Map<String, dynamic> json) {
    return ThemeConfig(
      name: json['name'] ?? 'MyApp',
      className: json['className'] ?? 'AppTheme',
      outputDir: json['outputDir'] ?? 'lib/theme',
      colors: ColorsConfig.fromJson(json['colors'] ?? {}),
      typography: TypographyConfig.fromJson(json['typography'] ?? {}),
      components: ComponentsConfig.fromJson(json['components'] ?? {}),
      generateExample: json['generateExample'] ?? false,
    );
  }

  static Future<ThemeConfig> loadFromFile(String filePath) async {
    final file = File(filePath);
    if (!file.existsSync()) {
      throw Exception('Fichier de configuration non trouvé: $filePath');
    }

    final content = await file.readAsString();
    final json = jsonDecode(content) as Map<String, dynamic>;
    return ThemeConfig.fromJson(json);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'className': className,
      'outputDir': outputDir,
      'colors': colors.toJson(),
      'typography': typography.toJson(),
      'components': components.toJson(),
      'generateExample': generateExample,
    };
  }
}

class ColorsConfig {
  final String primaryLight;
  final String primaryDark;
  final String? secondaryLight;
  final String? secondaryDark;
  final String? errorLight;
  final String? errorDark;
  final String? surfaceLight;
  final String? surfaceDark;
  final String? backgroundLight;
  final String? backgroundDark;

  ColorsConfig({
    required this.primaryLight,
    required this.primaryDark,
    this.secondaryLight,
    this.secondaryDark,
    this.errorLight,
    this.errorDark,
    this.surfaceLight,
    this.surfaceDark,
    this.backgroundLight,
    this.backgroundDark,
  });

  factory ColorsConfig.fromJson(Map<String, dynamic> json) {
    return ColorsConfig(
      primaryLight: json['primaryLight'] ?? '#1976D2',
      primaryDark: json['primaryDark'] ?? '#90CAF9',
      secondaryLight: json['secondaryLight'],
      secondaryDark: json['secondaryDark'],
      errorLight: json['errorLight'],
      errorDark: json['errorDark'],
      surfaceLight: json['surfaceLight'],
      surfaceDark: json['surfaceDark'],
      backgroundLight: json['backgroundLight'],
      backgroundDark: json['backgroundDark'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'primaryLight': primaryLight,
      'primaryDark': primaryDark,
      if (secondaryLight != null) 'secondaryLight': secondaryLight,
      if (secondaryDark != null) 'secondaryDark': secondaryDark,
      if (errorLight != null) 'errorLight': errorLight,
      if (errorDark != null) 'errorDark': errorDark,
      if (surfaceLight != null) 'surfaceLight': surfaceLight,
      if (surfaceDark != null) 'surfaceDark': surfaceDark,
      if (backgroundLight != null) 'backgroundLight': backgroundLight,
      if (backgroundDark != null) 'backgroundDark': backgroundDark,
    };
  }
}

class TypographyConfig {
  final String? fontFamily;
  final Map<String, TextStyleConfig>? customStyles;

  TypographyConfig({
    this.fontFamily,
    this.customStyles,
  });

  factory TypographyConfig.fromJson(Map<String, dynamic> json) {
    Map<String, TextStyleConfig>? customStyles;

    if (json['customStyles'] != null) {
      customStyles = {};
      final styles = json['customStyles'] as Map<String, dynamic>;
      styles.forEach((key, value) {
        customStyles![key] = TextStyleConfig.fromJson(value);
      });
    }

    return TypographyConfig(
      fontFamily: json['fontFamily'],
      customStyles: customStyles,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (fontFamily != null) 'fontFamily': fontFamily,
      if (customStyles != null)
        'customStyles': customStyles!.map((k, v) => MapEntry(k, v.toJson())),
    };
  }
}

class TextStyleConfig {
  final double? fontSize;
  final String? fontWeight;
  final double? letterSpacing;
  final double? height;

  TextStyleConfig({
    this.fontSize,
    this.fontWeight,
    this.letterSpacing,
    this.height,
  });

  factory TextStyleConfig.fromJson(Map<String, dynamic> json) {
    return TextStyleConfig(
      fontSize: json['fontSize']?.toDouble(),
      fontWeight: json['fontWeight'],
      letterSpacing: json['letterSpacing']?.toDouble(),
      height: json['height']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (fontSize != null) 'fontSize': fontSize,
      if (fontWeight != null) 'fontWeight': fontWeight,
      if (letterSpacing != null) 'letterSpacing': letterSpacing,
      if (height != null) 'height': height,
    };
  }

  String toCode() {
    final parts = <String>[];
    if (fontSize != null) parts.add('fontSize: $fontSize');
    if (fontWeight != null) parts.add('fontWeight: FontWeight.$fontWeight');
    if (letterSpacing != null) parts.add('letterSpacing: $letterSpacing');
    if (height != null) parts.add('height: $height');
    return parts.join(', ');
  }
}

class ComponentsConfig {
  final double? borderRadius;
  final double? elevation;
  final bool useMaterial3;
  final ButtonsConfig? buttons;
  final InputsConfig? inputs;
  final CardsConfig? cards;

  ComponentsConfig({
    this.borderRadius,
    this.elevation,
    this.useMaterial3 = true,
    this.buttons,
    this.inputs,
    this.cards,
  });

  factory ComponentsConfig.fromJson(Map<String, dynamic> json) {
    return ComponentsConfig(
      borderRadius: json['borderRadius']?.toDouble(),
      elevation: json['elevation']?.toDouble(),
      useMaterial3: json['useMaterial3'] ?? true,
      buttons: json['buttons'] != null ? ButtonsConfig.fromJson(json['buttons']) : null,
      inputs: json['inputs'] != null ? InputsConfig.fromJson(json['inputs']) : null,
      cards: json['cards'] != null ? CardsConfig.fromJson(json['cards']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (borderRadius != null) 'borderRadius': borderRadius,
      if (elevation != null) 'elevation': elevation,
      'useMaterial3': useMaterial3,
      if (buttons != null) 'buttons': buttons!.toJson(),
      if (inputs != null) 'inputs': inputs!.toJson(),
      if (cards != null) 'cards': cards!.toJson(),
    };
  }
}

class ButtonsConfig {
  final double? borderRadius;
  final double? elevation;
  final double? paddingHorizontal;
  final double? paddingVertical;

  ButtonsConfig({
    this.borderRadius,
    this.elevation,
    this.paddingHorizontal,
    this.paddingVertical,
  });

  factory ButtonsConfig.fromJson(Map<String, dynamic> json) {
    return ButtonsConfig(
      borderRadius: json['borderRadius']?.toDouble(),
      elevation: json['elevation']?.toDouble(),
      paddingHorizontal: json['paddingHorizontal']?.toDouble(),
      paddingVertical: json['paddingVertical']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (borderRadius != null) 'borderRadius': borderRadius,
      if (elevation != null) 'elevation': elevation,
      if (paddingHorizontal != null) 'paddingHorizontal': paddingHorizontal,
      if (paddingVertical != null) 'paddingVertical': paddingVertical,
    };
  }
}

class InputsConfig {
  final double? borderRadius;
  final bool filled;
  final double? paddingHorizontal;
  final double? paddingVertical;

  InputsConfig({
    this.borderRadius,
    this.filled = true,
    this.paddingHorizontal,
    this.paddingVertical,
  });

  factory InputsConfig.fromJson(Map<String, dynamic> json) {
    return InputsConfig(
      borderRadius: json['borderRadius']?.toDouble(),
      filled: json['filled'] ?? true,
      paddingHorizontal: json['paddingHorizontal']?.toDouble(),
      paddingVertical: json['paddingVertical']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (borderRadius != null) 'borderRadius': borderRadius,
      'filled': filled,
      if (paddingHorizontal != null) 'paddingHorizontal': paddingHorizontal,
      if (paddingVertical != null) 'paddingVertical': paddingVertical,
    };
  }
}

class CardsConfig {
  final double? borderRadius;
  final double? elevation;
  final double? margin;

  CardsConfig({
    this.borderRadius,
    this.elevation,
    this.margin,
  });

  factory CardsConfig.fromJson(Map<String, dynamic> json) {
    return CardsConfig(
      borderRadius: json['borderRadius']?.toDouble(),
      elevation: json['elevation']?.toDouble(),
      margin: json['margin']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (borderRadius != null) 'borderRadius': borderRadius,
      if (elevation != null) 'elevation': elevation,
      if (margin != null) 'margin': margin,
    };
  }
}