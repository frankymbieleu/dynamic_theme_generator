import 'dart:convert';
import 'dart:io';
import 'package:dynamic_theme_generator/dynamic_theme_generator.dart';

void main(List<String> args) async {
  try {
    final configPath = args.isNotEmpty ? args[0] : 'theme_config.json';
    final configFile = File(configPath);
    
    if (!await configFile.exists()) {
      throw Exception('Fichier de configuration $configPath introuvable.');
    }

    final configString = await configFile.readAsString();
    final configJson = jsonDecode(configString);
    final themeConfig = ThemeConfig.fromJson(configJson);

    final generatedContent = """
// GENERATED FILE - DO NOT EDIT
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  // Couleurs de base
  static const Color _primaryLight = Color(0x${themeConfig.primaryLight.value.toRadixString(16)});
  static const Color _primaryDark = Color(0x${themeConfig.primaryDark.value.toRadixString(16)});
  static const Color _secondaryLight = Color(0x${themeConfig.secondaryLight.value.toRadixString(16)});
  static const Color _secondaryDark = Color(0x${themeConfig.secondaryDark.value.toRadixString(16)});
  static const Color _errorLight = Color(0x${themeConfig.errorLight.value.toRadixString(16)});
  static const Color _errorDark = Color(0x${themeConfig.errorDark.value.toRadixString(16)});
  
  // Couleurs de surface
  static const Color _surfaceLight = Color(0x${themeConfig.surfaceLight.value.toRadixString(16)});
  static const Color _surfaceDark = Color(0x${themeConfig.surfaceDark.value.toRadixString(16)});
  static const Color _backgroundLight = Color(0x${themeConfig.backgroundLight.value.toRadixString(16)});
  static const Color _backgroundDark = Color(0x${themeConfig.backgroundDark.value.toRadixString(16)});
  
  // Couleurs de texte
  static const Color _onPrimaryLight = Color(0x${themeConfig.onPrimaryLight.value.toRadixString(16)});
  static const Color _onPrimaryDark = Color(0x${themeConfig.onPrimaryDark.value.toRadixString(16)});
  static const Color _onSurfaceLight = Color(0x${themeConfig.onSurfaceLight.value.toRadixString(16)});
  static const Color _onSurfaceDark = Color(0x${themeConfig.onSurfaceDark.value.toRadixString(16)});
  
  // Schémas de couleurs
  static final ColorScheme _lightColorScheme = ColorScheme.fromSeed(
    seedColor: _primaryLight,
    brightness: Brightness.light,
    primary: _primaryLight,
    secondary: _secondaryLight,
    error: _errorLight,
    surface: _surfaceLight,
    background: _backgroundLight,
    onPrimary: _onPrimaryLight,
    onSurface: _onSurfaceLight,
  );

  static final ColorScheme _darkColorScheme = ColorScheme.fromSeed(
    seedColor: _primaryDark,
    brightness: Brightness.dark,
    primary: _primaryDark,
    secondary: _secondaryDark,
    error: _errorDark,
    surface: _surfaceDark,
    background: _backgroundDark,
    onPrimary: _onPrimaryDark,
    onSurface: _onSurfaceDark,
  );

  // Typographie
  static const TextTheme _textTheme = TextTheme(
    displayLarge: TextStyle(
      fontSize: 57,
      fontWeight: FontWeight.w400,
      letterSpacing: -0.25,
      height: 1.12,
      fontFamily: '${themeConfig.fontFamily}',
    ),
    displayMedium: TextStyle(
      fontSize: 45,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      height: 1.16,
      fontFamily: '${themeConfig.fontFamily}',
    ),
    displaySmall: TextStyle(
      fontSize: 36,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      height: 1.22,
      fontFamily: '${themeConfig.fontFamily}',
    ),
    headlineLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      height: 1.25,
      fontFamily: '${themeConfig.fontFamily}',
    ),
    headlineMedium: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      height: 1.29,
      fontFamily: '${themeConfig.fontFamily}',
    ),
    headlineSmall: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      height: 1.33,
      fontFamily: '${themeConfig.fontFamily}',
    ),
    titleLarge: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w500,
      letterSpacing: 0,
      height: 1.27,
      fontFamily: '${themeConfig.fontFamily}',
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15,
      height: 1.50,
      fontFamily: '${themeConfig.fontFamily}',
    ),
    titleSmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
      height: 1.43,
      fontFamily: '${themeConfig.fontFamily}',
    ),
    labelLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
      height: 1.43,
      fontFamily: '${themeConfig.fontFamily}',
    ),
    labelMedium: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
      height: 1.33,
      fontFamily: '${themeConfig.fontFamily}',
    ),
    labelSmall: TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
      height: 1.45,
      fontFamily: '${themeConfig.fontFamily}',
    ),
    bodyLarge: TextStyle(
      fontSize: ${themeConfig.baseFontSize},
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
      height: 1.50,
      fontFamily: '${themeConfig.fontFamily}',
    ),
    bodyMedium: TextStyle(
      fontSize: ${themeConfig.baseFontSize * 0.875},
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      height: 1.43,
      fontFamily: '${themeConfig.fontFamily}',
    ),
    bodySmall: TextStyle(
      fontSize: ${themeConfig.baseFontSize * 0.75},
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
      height: 1.33,
      fontFamily: '${themeConfig.fontFamily}',
    ),
  );

  // Configuration des composants
  static InputDecorationTheme _inputDecorationTheme(ColorScheme colorScheme) {
    return InputDecorationTheme(
      filled: true,
      fillColor: colorScheme.surfaceVariant.withOpacity(0.04),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: colorScheme.outline),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: colorScheme.outline),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: colorScheme.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: colorScheme.error),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      hintStyle: TextStyle(color: colorScheme.onSurfaceVariant),
    );
  }

  static ElevatedButtonThemeData _elevatedButtonTheme(ColorScheme colorScheme) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 1,
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        textStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
        ),
      ),
    );
  }

  static TextButtonThemeData _textButtonTheme(ColorScheme colorScheme) {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        textStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
        ),
      ),
    );
  }

  static CardTheme _cardTheme(ColorScheme colorScheme) {
    return CardTheme(
      elevation: 1,
      color: colorScheme.surface,
      shadowColor: colorScheme.shadow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: const EdgeInsets.all(8),
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
        letterSpacing: 0,
      ),
    );
  }

  static BottomNavigationBarThemeData _bottomNavTheme(ColorScheme colorScheme) {
    return BottomNavigationBarThemeData(
      backgroundColor: colorScheme.surface,
      selectedItemColor: colorScheme.primary,
      unselectedItemColor: colorScheme.onSurfaceVariant,
      type: BottomNavigationBarType.fixed,
      elevation: 3,
    );
  }

  static FloatingActionButtonThemeData _fabTheme(ColorScheme colorScheme) {
    return FloatingActionButtonThemeData(
      backgroundColor: colorScheme.primaryContainer,
      foregroundColor: colorScheme.onPrimaryContainer,
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }

  static ChipThemeData _chipTheme(ColorScheme colorScheme) {
    return ChipThemeData(
      backgroundColor: colorScheme.surfaceVariant.withOpacity(0.12),
      selectedColor: colorScheme.secondaryContainer,
      disabledColor: colorScheme.onSurface.withOpacity(0.12),
      deleteIconColor: colorScheme.onSurfaceVariant,
      labelStyle: TextStyle(
        color: colorScheme.onSurfaceVariant,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      secondaryLabelStyle: TextStyle(
        color: colorScheme.onSecondaryContainer,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      side: BorderSide.none,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    );
  }

  // Thème Light
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: _lightColorScheme,
    textTheme: _textTheme,
    inputDecorationTheme: _inputDecorationTheme(_lightColorScheme),
    elevatedButtonTheme: _elevatedButtonTheme(_lightColorScheme),
    outlinedButtonTheme: _outlinedButtonTheme(_lightColorScheme),
    textButtonTheme: _textButtonTheme(_lightColorScheme),
    cardTheme: _cardTheme(_lightColorScheme),
    appBarTheme: _appBarTheme(_lightColorScheme),
    bottomNavigationBarTheme: _bottomNavTheme(_lightColorScheme),
    floatingActionButtonTheme: _fabTheme(_lightColorScheme),
    chipTheme: _chipTheme(_lightColorScheme),
    dividerColor: _lightColorScheme.outline.withOpacity(0.12),
    scaffoldBackgroundColor: _lightColorScheme.background,
    splashFactory: InkRipple.splashFactory,
  );

  // Thème Dark
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: _darkColorScheme,
    textTheme: _textTheme,
    inputDecorationTheme: _inputDecorationTheme(_darkColorScheme),
    elevatedButtonTheme: _elevatedButtonTheme(_darkColorScheme),
    outlinedButtonTheme: _outlinedButtonTheme(_darkColorScheme),
    textButtonTheme: _textButtonTheme(_darkColorScheme),
    cardTheme: _cardTheme(_darkColorScheme),
    appBarTheme: _appBarTheme(_darkColorScheme),
    bottomNavigationBarTheme: _bottomNavTheme(_darkColorScheme),
    floatingActionButtonTheme: _fabTheme(_darkColorScheme),
    chipTheme: _chipTheme(_darkColorScheme),
    dividerColor: _darkColorScheme.outline.withOpacity(0.12),
    scaffoldBackgroundColor: _darkColorScheme.background,
    splashFactory: InkRipple.splashFactory,
  );
}
""";

    final outputFile = File('lib/generated_theme.dart');
    await outputFile.writeAsString(generatedContent);
    print('Fichier de style généré avec succès : ${outputFile.path}');
  } catch (e) {
    print('Erreur lors de la génération du thème : $e');
    exit(1);
  }
}