import 'dart:io';
import 'package:args/args.dart';
import '../models/theme_config.dart';
import '../generators/theme_generator.dart';
import '../utils/logger.dart';

class GenerateCommand {
  static void setupArguments(ArgParser parser) {
    parser.addOption(
      'config',
      abbr: 'c',
      help: 'Chemin vers le fichier de configuration JSON',
      defaultsTo: 'theme_config.json',
    );

    parser.addOption(
      'output',
      abbr: 'o',
      help: 'Répertoire de sortie (remplace la valeur du JSON)',
    );

    parser.addFlag(
      'example',
      abbr: 'e',
      help: 'Générer un fichier d\'exemple (remplace la valeur du JSON)',
      defaultsTo: false,
    );

    parser.addFlag(
      'watch',
      abbr: 'w',
      help: 'Surveiller les changements du fichier de configuration',
      defaultsTo: false,
    );

    parser.addFlag(
      'help',
      abbr: 'h',
      help: 'Afficher l\'aide pour la commande generate',
      negatable: false,
    );
  }

  static Future<void> execute(ArgResults args) async {
    if (args['help'] as bool) {
      _showHelp();
      return;
    }

    final configPath = args['config'] as String;
    final outputOverride = args['output'] as String?;
    final exampleOverride = args['example'] as bool;
    final watch = args['watch'] as bool;

    if (watch) {
      await _watchAndGenerate(configPath, outputOverride, exampleOverride);
    } else {
      await _generateOnce(configPath, outputOverride, exampleOverride);
    }
  }

  static Future<void> _generateOnce(String configPath, String? outputOverride, bool exampleOverride) async {
    try {
      final config = await _loadConfig(configPath, outputOverride, exampleOverride);
      final generator = ThemeGenerator(config);
      await generator.generate();
    } catch (e) {
      Logger.error('❌ Erreur: $e');
      exit(1);
    }
  }

  static Future<void> _watchAndGenerate(String configPath, String? outputOverride, bool exampleOverride) async {
    Logger.info('👁️  Surveillance du fichier: $configPath');
    Logger.info('💡 Appuyez sur Ctrl+C pour arrêter');

    final file = File(configPath);

    // Génération initiale
    await _generateOnce(configPath, outputOverride, exampleOverride);

    // Surveillance des changements
    await for (final event in file.watch()) {
      if (event.type == FileSystemEvent.modify) {
        Logger.info('📝 Fichier modifié, régénération...');
        try {
          await _generateOnce(configPath, outputOverride, exampleOverride);
        } catch (e) {
          Logger.error('❌ Erreur lors de la régénération: $e');
        }
      }
    }
  }

  static Future<ThemeConfig> _loadConfig(String configPath, String? outputOverride, bool exampleOverride) async {
    if (!File(configPath).existsSync()) {
      throw Exception(
          'Fichier de configuration non trouvé: $configPath\n'
              '💡 Lancez "dart run dynamic_theme_generator init" pour en créer un'
      );
    }

    Logger.info('📖 Chargement de la configuration: $configPath');
    var config = await ThemeConfig.loadFromFile(configPath);

    // Appliquer les overrides des arguments CLI
    if (outputOverride != null || exampleOverride) {
      config = ThemeConfig(
        name: config.name,
        className: config.className,
        outputDir: outputOverride ?? config.outputDir,
        colors: config.colors,
        typography: config.typography,
        components: config.components,
        generateExample: exampleOverride || config.generateExample,
      );
    }

    return config;
  }

  static void _showHelp() {
    print('''
⚡ Commande: generate

DESCRIPTION:
  Génère les fichiers de thème Flutter à partir d'un fichier de configuration JSON.

UTILISATION:
  dart run dynamic_theme_generator generate [options]

OPTIONS:
  -c, --config=<fichier>    Fichier de configuration (défaut: theme_config.json)
  -o, --output=<dossier>    Répertoire de sortie
  -e, --example            Générer un fichier d'exemple
  -w, --watch              Surveiller les changements et régénérer automatiquement
  -h, --help               Afficher cette aide

EXEMPLES:
  dart run dynamic_theme_generator generate
  dart run dynamic_theme_generator generate --config my_theme.json
  dart run dynamic_theme_generator generate --output lib/themes --example
  dart run dynamic_theme_generator generate --watch
''');
  }
}