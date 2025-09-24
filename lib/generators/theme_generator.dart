import 'dart:io';
import 'package:path/path.dart' as path;
import '../models/theme_config.dart';
import '../utils/logger.dart';

class ThemeGenerator {
  final ThemeConfig config;

  ThemeGenerator(this.config);

  Future<void> generate() async {
    Logger.info('🎨 Génération du thème "${config.className}"...');

    await _createOutputDirectory();
    await _generateThemeFile();

    if (config.generateExample) {
      await _generateExampleFile();
      Logger.success('📱 Fichier d\'exemple généré');
    }

    Logger.success('✅ Thème généré avec succès dans ${config.outputDir}/');
    Logger.info('💡 Importez le thème : import \'${config.outputDir}/${_toSnakeCase(config.className)}.dart\';');
  }

  Future<void> _createOutputDirectory() async {
    final dir = Directory(config.outputDir);
    if (!dir.existsSync()) {
      await dir.create(recursive: true);
      Logger.info('📁 Répertoire créé: ${config.outputDir}');
    }
  }

  Future<void> _generateThemeFile() async {
    final content = _buildThemeContent();
    final fileName = '${_toSnakeCase(config.className)}.dart';
    final file = File(path.join(config.outputDir, fileName));

    await file.writeAsString(content);
    Logger.success('🎨 Fichier de thème généré: $fileName');
  }

  Future<void> _generateExampleFile() async {
    final content = _buildExampleContent();
    final file = File(path.join(config.outputDir, 'theme_example.dart'));
    await file.writeAsString(content);
  }

  String _buildThemeContent() {
    return '''
// GÉNÉRÉ AUTOMATIQUEMENT - NE PAS MODIFIER MANUELLEMENT
// Généré le ${DateTime.now().toString()}
// Configuration: ${config.name}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Thème personnalisé pour ${config.name}
/// 
/// Utilisation:
/// ```dart
/// MaterialApp(
///   theme: ${config.className}.lightTheme,
///   darkTheme: ${config.className}.darkTheme,
///   themeMode: ThemeMode.system,
/// )
/// ```
class ${config.className} {
  ${_buildColorConstants()}

  ${_buildColorSchemes()}

  ${_buildTextTheme()}

  ${_buildComponentThemes()}

  /// Thème clair
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: ${config.components.useMaterial3},
      colorScheme: _lightColorScheme,
      textTheme: _textTheme,
      ${config.typography.fontFamily != null ? 'fontFamily: \'${config.typography.fontFamily}\',' : ''}
      
      // Configuration des composants
      inputDecorationTheme: _inputDecorationTheme(_lightColorScheme),
      elevatedButtonTheme: _elevatedButtonTheme(_lightColorScheme),
      outlinedButtonTheme: _outlinedButtonTheme(_lightColorScheme),
      textButtonTheme: _textButtonTheme(_lightColorScheme),
      cardTheme: _cardTheme(_lightColorScheme),
      appBarTheme: _appBarTheme(_lightColorScheme),
      
      // Autres propriétés
      scaffoldBackgroundColor: _lightColorScheme.background,
      dividerColor: _lightColorScheme.outline.withOpacity(0.12),
      splashFactory: InkRipple.splashFactory,
    );
  }

  /// Thème sombre
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: ${config.components.useMaterial3},
      colorScheme: _darkColorScheme,
      textTheme: _textTheme,
      ${config.typography.fontFamily != null ? 'fontFamily: \'${config.typography.fontFamily}\',' : ''}
      
      // Configuration des composants
      inputDecorationTheme: _inputDecorationTheme(_darkColorScheme),
      elevatedButtonTheme: _elevatedButtonTheme(_darkColorScheme),
      outlinedButtonTheme: _outlinedButtonTheme(_darkColorScheme),
      textButtonTheme: _textButtonTheme(_darkColorScheme),
      cardTheme: _cardTheme(_darkColorScheme),
      appBarTheme: _appBarTheme(_darkColorScheme),
      
      // Autres propriétés
      scaffoldBackgroundColor: _darkColorScheme.background,
      dividerColor: _darkColorScheme.outline.withOpacity(0.12),
      splashFactory: InkRipple.splashFactory,
    );
  }
}
''';
  }

  String _buildColorConstants() {
    return '''
  // === COULEURS DE BASE ===
  static const Color _primaryLight = Color(${_hexToColorCode(config.colors.primaryLight)});
  static const Color _primaryDark = Color(${_hexToColorCode(config.colors.primaryDark)});
  ${config.colors.secondaryLight != null ? 'static const Color _secondaryLight = Color(${_hexToColorCode(config.colors.secondaryLight!)});' : 'static const Color _secondaryLight = Color(0xFF03DAC6);'}
  ${config.colors.secondaryDark != null ? 'static const Color _secondaryDark = Color(${_hexToColorCode(config.colors.secondaryDark!)});' : 'static const Color _secondaryDark = Color(0xFF03DAC6);'}
  ${config.colors.errorLight != null ? 'static const Color _errorLight = Color(${_hexToColorCode(config.colors.errorLight!)});' : 'static const Color _errorLight = Color(0xFFB00020);'}
  ${config.colors.errorDark != null ? 'static const Color _errorDark = Color(${_hexToColorCode(config.colors.errorDark!)});' : 'static const Color _errorDark = Color(0xFFCF6679);'}
  
  // Couleurs de surface
  ${config.colors.surfaceLight != null ? 'static const Color _surfaceLight = Color(${_hexToColorCode(config.colors.surfaceLight!)});' : 'static const Color _surfaceLight = Color(0xFFFFFBFE);'}
  ${config.colors.surfaceDark != null ? 'static const Color _surfaceDark = Color(${_hexToColorCode(config.colors.surfaceDark!)});' : 'static const Color _surfaceDark = Color(0xFF121212);'}
  ${config.colors.backgroundLight != null ? 'static const Color _backgroundLight = Color(${_hexToColorCode(config.colors.backgroundLight!)});' : 'static const Color _backgroundLight = Color(0xFFFFFBFE);'}
  ${config.colors.backgroundDark != null ? 'static const Color _backgroundDark = Color(${_hexToColorCode(config.colors.backgroundDark!)});' : 'static const Color _backgroundDark = Color(0xFF121212);'}''';
  }

  String _buildColorSchemes() {
    return '''
  // === SCHÉMAS DE COULEURS ===
  static final ColorScheme _lightColorScheme = ColorScheme.fromSeed(
    seedColor: _primaryLight,
    brightness: Brightness.light,
    primary: _primaryLight,
    secondary: _secondaryLight,
    error: _errorLight,
    surface: _surfaceLight,
    background: _backgroundLight,
  );

  static final ColorScheme _darkColorScheme = ColorScheme.fromSeed(
    seedColor: _primaryDark,
    brightness: Brightness.dark,
    primary: _primaryDark,
    secondary: _secondaryDark,
    error: _errorDark,
    surface: _surfaceDark,
    background: _backgroundDark,
  );''';
  }

  String _buildTextTheme() {
    if (config.typography.customStyles?.isEmpty ?? true) {
      return '''
  // === TYPOGRAPHIE ===
  static const TextTheme _textTheme = TextTheme(
    // Utilise les valeurs par défaut Material Design 3
  );''';
    }

    final customStyles = config.typography.customStyles!;
    final styleEntries = customStyles.entries.map((entry) {
      return '    ${entry.key}: TextStyle(${entry.value.toCode()}),';
    }).join('\n');

    return '''
  // === TYPOGRAPHIE ===
  static const TextTheme _textTheme = TextTheme(
$styleEntries
  );''';
  }

  String _buildComponentThemes() {
    return '''
  // === THÈMES DES COMPOSANTS ===
  
  static InputDecorationTheme _inputDecorationTheme(ColorScheme colorScheme) {
    return InputDecorationTheme(
      filled: ${config.components.inputs?.filled ?? true},
      fillColor: colorScheme.surfaceVariant.withOpacity(0.04),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(${config.components.inputs?.borderRadius ?? config.components.borderRadius ?? 12}),
        borderSide: BorderSide(color: colorScheme.outline),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(${config.components.inputs?.borderRadius ?? config.components.borderRadius ?? 12}),
        borderSide: BorderSide(color: colorScheme.outline),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(${config.components.inputs?.borderRadius ?? config.components.borderRadius ?? 12}),
        borderSide: BorderSide(color: colorScheme.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(${config.components.inputs?.borderRadius ?? config.components.borderRadius ?? 12}),
        borderSide: BorderSide(color: colorScheme.error),
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: ${config.components.inputs?.paddingHorizontal ?? 16},
        vertical: ${config.components.inputs?.paddingVertical ?? 16},
      ),
    );
  }

  static ElevatedButtonThemeData _elevatedButtonTheme(ColorScheme colorScheme) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: ${config.components.buttons?.elevation ?? config.components.elevation ?? 1},
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(${config.components.buttons?.borderRadius ?? config.components.borderRadius ?? 12}),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: ${config.components.buttons?.paddingHorizontal ?? 24},
          vertical: ${config.components.buttons?.paddingVertical ?? 12},
        ),
        textStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
        ),
      ),
    );
  }

  static OutlinedButtonThemeData _outlinedButtonTheme(ColorScheme colorScheme) {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: colorScheme.primary,
        side: BorderSide(color: colorScheme.outline),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(${config.components.buttons?.borderRadius ?? config.components.borderRadius ?? 12}),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: ${config.components.buttons?.paddingHorizontal ?? 24},
          vertical: ${config.components.buttons?.paddingVertical ?? 12},
        ),
      ),
    );
  }

  static TextButtonThemeData _textButtonTheme(ColorScheme colorScheme) {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(${config.components.buttons?.borderRadius ?? config.components.borderRadius ?? 12}),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    );
  }

  static CardTheme _cardTheme(ColorScheme colorScheme) {
    return CardTheme(
      elevation: ${config.components.cards?.elevation ?? config.components.elevation ?? 1},
      color: colorScheme.surface,
      shadowColor: colorScheme.shadow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(${config.components.cards?.borderRadius ?? config.components.borderRadius ?? 16}),
      ),
      margin: EdgeInsets.all(${config.components.cards?.margin ?? 8}),
    );
  }

  static AppBarTheme _appBarTheme(ColorScheme colorScheme) {
    return AppBarTheme(
      elevation: 0,
      centerTitle: true,
      backgroundColor: colorScheme.surface,
      foregroundColor: colorScheme.onSurface,
      surfaceTintColor: Colors.transparent,
      systemOverlayStyle: colorScheme.brightness == Brightness.light
          ? SystemUiOverlayStyle.dark
          : SystemUiOverlayStyle.light,
      titleTextStyle: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w500,
        color: colorScheme.onSurface,
      ),
    );
  }''';
  }

  String _buildExampleContent() {
    return '''
// EXEMPLE D'UTILISATION DU THÈME ${config.className}
// Ce fichier montre comment utiliser votre thème personnalisé

import 'package:flutter/material.dart';
import '${_toSnakeCase(config.className)}.dart';

void main() {
  runApp(const ${config.className}ExampleApp());
}

class ${config.className}ExampleApp extends StatefulWidget {
  const ${config.className}ExampleApp({super.key});

  @override
  State<${config.className}ExampleApp> createState() => _${config.className}ExampleAppState();
}

class _${config.className}ExampleAppState extends State<${config.className}ExampleApp> {
  ThemeMode _themeMode = ThemeMode.system;

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light 
          ? ThemeMode.dark 
          : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '${config.name} - Thème Demo',
      theme: ${config.className}.lightTheme,
      darkTheme: ${config.className}.darkTheme,
      themeMode: _themeMode,
      home: _ExampleHomePage(onThemeToggle: _toggleTheme),
      debugShowCheckedModeBanner: false,
    );
  }
}

class _ExampleHomePage extends StatefulWidget {
  final VoidCallback onThemeToggle;
  
  const _ExampleHomePage({required this.onThemeToggle});

  @override
  State<_ExampleHomePage> createState() => _ExampleHomePageState();
}

class _ExampleHomePageState extends State<_ExampleHomePage> {
  final _textController = TextEditingController();
  bool _switchValue = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('${config.name} Theme'),
        actions: [
          IconButton(
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
            onPressed: widget.onThemeToggle,
            tooltip: 'Basculer le thème',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section info
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Thème ${config.name}',
                      style: theme.textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Mode actuel: {isDark ? 'Sombre' : 'Clair'}',
                      style: theme.textTheme.bodyMedium,
                    ),
                    Text(
                      'Généré automatiquement par Flutter Theme Generator',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Section boutons
            Text(
              'Boutons',
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Elevated'),
                ),
                OutlinedButton(
                  onPressed: () {},
                  child: const Text('Outlined'),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Text Button'),
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add),
                  label: const Text('Avec icône'),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Section formulaires
            Text(
              'Formulaires',
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _textController,
              decoration: const InputDecoration(
                labelText: 'Nom',
                hintText: 'Entrez votre nom',
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Email',
                hintText: 'exemple@email.com',
                prefixIcon: Icon(Icons.email),
                suffixIcon: Icon(Icons.check_circle),
              ),
            ),

            const SizedBox(height: 24),

            // Section contrôles
            Text(
              'Contrôles',
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('Notifications'),
              subtitle: const Text('Activer les notifications'),
              value: _switchValue,
              onChanged: (value) {
                setState(() {
                  _switchValue = value;
                });
              },
            ),

            const SizedBox(height: 100), // Espace pour le FAB
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Thème {isDark ? 'sombre' : 'clair'} actif!',
              ),
              action: SnackBarAction(
                label: 'OK',
                onPressed: () {},
              ),
            ),
          );
        },
        child: const Icon(Icons.palette),
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
''';
  }

  String _hexToColorCode(String hex) {
    hex = hex.replaceAll('#', '');
    if (hex.length == 6) {
      hex = 'FF$hex';
    }
    return '0x$hex';
  }

  String _toSnakeCase(String str) {
    return str
        .replaceAllMapped(RegExp(r'(?<=[a-z])(?=[A-Z])'), (match) => '_')
        .toLowerCase();
  }
}