#!/usr/bin/env dart

import 'dart:io';
import 'package:args/args.dart';
import 'package:dynamic_theme_generator/command/generate_command.dart';
import 'package:dynamic_theme_generator/command/init_command.dart';
import 'package:dynamic_theme_generator/utils/logger.dart';


void main(List<String> arguments) async {
  final parser = ArgParser();

  parser.addFlag(
    'help',
    abbr: 'h',
    help: 'Afficher l\'aide',
    negatable: false,
  );

  parser.addFlag(
    'version',
    abbr: 'v',
    help: 'Afficher la version',
    negatable: false,
  );

  // Commande init
  final initCommand = parser.addCommand('init');
  InitCommand.setupArguments(initCommand);

  // Commande generate
  final generateCommand = parser.addCommand('generate');
  GenerateCommand.setupArguments(generateCommand);

  try {
    final results = parser.parse(arguments);

    if (results['help'] as bool) {
      _showHelp(parser);
      return;
    }

    if (results['version'] as bool) {
      Logger.info('Flutter Theme Generator v1.0.0');
      return;
    }

    final command = results.command;

    if (command == null) {
      Logger.error('Aucune commande spécifiée');
      _showHelp(parser);
      exit(1);
    }

    switch (command.name) {
      case 'init':
        await InitCommand.execute(command);
        break;

      case 'generate':
        await GenerateCommand.execute(command);
        break;

      default:
        Logger.error('Commande inconnue: ${command.name}');
        _showHelp(parser);
        exit(1);
    }

  } catch (e) {
    Logger.error('Erreur: $e');
    exit(1);
  }
}

void _showHelp(ArgParser parser) {
  print('''
🎨 Flutter Theme Generator

UTILISATION:
  dart run dynamic_theme_generator <commande> [options]

COMMANDES:
  init      Créer un fichier de configuration par défaut
  generate  Générer les fichiers de thème à partir de la configuration

OPTIONS:
${parser.usage}

EXEMPLES:
  dart run dynamic_theme_generator init
  dart run dynamic_theme_generator generate
  dart run dynamic_theme_generator generate --config my_theme.json
  ''');
}