import 'dart:convert';
import 'dart:io';
import 'package:args/args.dart';
import '../utils/logger.dart';
import '../models/theme_config.dart';

class InitCommand {
  static void setupArguments(ArgParser parser) {
    parser.addOption(
      'output',
      abbr: 'o',
      help: 'Nom du fichier de configuration à créer',
      defaultsTo: 'theme_config.json',
    );

    parser.addFlag(
      'force',
      abbr: 'f',
      help: 'Écraser le fichier s\'il existe déjà',
      defaultsTo: false,
    );

    parser.addFlag(
      'help',
      abbr: 'h',
      help: 'Afficher l\'aide pour la commande init',
      negatable: false,
    );
  }

  static Future<void> execute(ArgResults args) async {
    if (args['help'] as bool) {
      _showHelp();
      return;
    }

    final outputFile = args['output'] as String;
    final force = args['force'] as bool;

    final file = File(outputFile);

    if (file.existsSync() && !force) {
      Logger.warning('⚠️  Le fichier $outputFile existe déjà');
      Logger.info('💡 Utilisez --force pour l\'écraser ou changez le nom avec --output');
      return;
    }

    try {
      final defaultConfig = _createDefaultConfig();
      final jsonString = const JsonEncoder.withIndent('  ').convert(defaultConfig.toJson());

      await file.writeAsString(jsonString);

      Logger.success('✅ Fichier de configuration créé: $outputFile');
      Logger.info('');
      Logger.info('📝 Prochaines étapes:');
      Logger.info('  1. Éditez $outputFile selon vos préférences');
      Logger.info('  2. Lancez: dart run dynamic_theme_generator generate');
      Logger.info('');
      Logger.info('💡 Exemple de génération avec options:');
      Logger.info('   dart run dynamic_theme_generator generate --config $outputFile');

    } catch (e) {
      Logger.error('❌ Erreur lors de la création du fichier: $e');
      exit(1);
    }
  }

  static ThemeConfig _createDefaultConfig() {
    return ThemeConfig(
      name: 'Mon Application',
      className: 'AppTheme',
      outputDir: 'lib/theme',
      generateExample: true,
      colors: ColorsConfig(
        primaryLight: '#2196F3',
        primaryDark: '#90CAF9',
        secondaryLight: '#FF9800',
        secondaryDark: '#FFB74D',
        errorLight: '#F44336',
        errorDark: '#EF5350',
      ),
      typography: TypographyConfig(
        fontFamily: 'Roboto',
        customStyles: {
          'headlineLarge': TextStyleConfig(
            fontSize: 32.0,
            fontWeight: 'w700',
            letterSpacing: -0.5,
            height: 1.25,
          ),
          'titleLarge': TextStyleConfig(
            fontSize: 22.0,
            fontWeight: 'w600',
            letterSpacing: 0.0,
            height: 1.27,
          ),
          'bodyLarge': TextStyleConfig(
            fontSize: 16.0,
            fontWeight: 'w400',
            letterSpacing: 0.5,
            height: 1.5,
          ),
        },
      ),
      components: ComponentsConfig(
        borderRadius: 12.0,
        elevation: 2.0,
        useMaterial3: true,
        buttons: ButtonsConfig(
          borderRadius: 8.0,
          elevation: 1.0,
          paddingHorizontal: 24.0,
          paddingVertical: 12.0,
        ),
        inputs: InputsConfig(
          borderRadius: 8.0,
          filled: true,
          paddingHorizontal: 16.0,
          paddingVertical: 16.0,
        ),
        cards: CardsConfig(
          borderRadius: 12.0,
          elevation: 2.0,
          margin: 8.0,
        ),
      ),
    );
  }

  static void _showHelp() {
    print('''
📝 Commande: init

DESCRIPTION:
  Crée un fichier de configuration JSON avec des valeurs par défaut.

UTILISATION:
  dart run dynamic_theme_generator init [options]

OPTIONS:
  -o, --output=<fichier>    Nom du fichier à créer (défaut: theme_config.json)
  -f, --force              Écraser le fichier s'il existe
  -h, --help               Afficher cette aide

EXEMPLES:
  dart run dynamic_theme_generator init
  dart run dynamic_theme_generator init --output my_theme.json
  dart run dynamic_theme_generator init --force
''');
  }
}