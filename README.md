# 🎨 Flutter Theme Generator

Un package Flutter pour générer automatiquement des thèmes personnalisés à partir d'une configuration JSON simple.

## ✨ Fonctionnalités

- 🎯 **Simple**: Configuration via JSON
- ⚡ **Rapide**: Génération en une commande
- 🌗 **Complet**: Thèmes Light/Dark automatiques
- 🎨 **Personnalisable**: Couleurs, typographie, composants
- 📱 **Material 3**: Support complet des derniers standards
- 👀 **Watch mode**: Régénération automatique
- 📝 **Exemples**: Code d'utilisation généré

## 🚀 Installation

Ajoutez le package à votre `pubspec.yaml`:

```yaml
dev_dependencies:
  dynamic_theme_generator: ^1.0.0
```

Puis installez:
```bash
flutter pub get
```

## 📖 Utilisation rapide

### 1. Initialiser la configuration

```bash
dart run dynamic_theme_generator init
```

Cela crée un fichier `theme_config.json` avec des valeurs par défaut.

### 2. Personnaliser la configuration

Éditez `theme_config.json`:

```json
{
  "name": "Mon Application",
  "className": "AppTheme",
  "outputDir": "lib/theme",
  "generateExample": true,
  "colors": {
    "primaryLight": "#2196F3",
    "primaryDark": "#90CAF9",
    "secondaryLight": "#FF9800",
    "secondaryDark": "#FFB74D"
  },
  "typography": {
    "fontFamily": "Roboto",
    "customStyles": {
      "headlineLarge": {
        "fontSize": 32.0,
        "fontWeight": "w700"
      }
    }
  },
  "components": {
    "borderRadius": 12.0,
    "useMaterial3": true,
    "buttons": {
      "borderRadius": 8.0,
      "paddingHorizontal": 24.0,
      "paddingVertical": 12.0
    }
  }
}
```

### 3. Générer le thème

```bash
dart run dynamic_theme_generator generate
```

### 4. Utiliser dans votre app

```dart
import 'package:flutter/material.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mon App',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const MyHomePage(),
    );
  }
}
```

## 📋 Commandes disponibles

| Commande | Description | Options |
|----------|-------------|---------|
| `init` | Créer un fichier de configuration | `--output`, `--force` |
| `generate` | Générer les thèmes | `--config`, `--output`, `--example`, `--watch` |

### Commande init

```bash
# Créer theme_config.json
dart run dynamic_theme_generator init

# Créer un fichier personnalisé
dart run dynamic_theme_generator init --output my_theme.json

# Écraser un fichier existant
dart run dynamic_theme_generator init --force
```

### Commande generate

```bash
# Génération simple
dart run dynamic_theme_generator generate

# Avec fichier de config personnalisé
dart run dynamic_theme_generator generate --config my_theme.json

# Avec exemple et sortie personnalisée
dart run dynamic_theme_generator generate --output lib/themes --example

# Mode surveillance (régénère automatiquement)
dart run dynamic_theme_generator generate --watch
```

## ⚙️ Configuration JSON

### Structure complète

```json
{
  "name": "Nom de l'application",
  "className": "NomDeLaClasse",
  "outputDir": "lib/theme",
  "generateExample": true,
  
  "colors": {
    "primaryLight": "#couleur",
    "primaryDark": "#couleur",
    "secondaryLight": "#couleur",
    "secondaryDark": "#couleur",
    "errorLight": "#couleur",
    "errorDark": "#couleur",
    "surfaceLight": "#couleur",
    "surfaceDark": "#couleur",
    "backgroundLight": "#couleur",
    "backgroundDark": "#couleur"
  },
  
  "typography": {
    "fontFamily": "NomPolice",
    "customStyles": {
      "headlineLarge": {
        "fontSize": 32.0,
        "fontWeight": "w700",
        "letterSpacing": -0.5,
        "height": 1.25
      }
    }
  },
  
  "components": {
    "borderRadius": 12.0,
    "elevation": 2.0,
    "useMaterial3": true,
    
    "buttons": {
      "borderRadius": 8.0,
      "elevation": 1.0,
      "paddingHorizontal": 24.0,
      "paddingVertical": 12.0
    },
    
    "inputs": {
      "borderRadius": 8.0,
      "filled": true,
      "paddingHorizontal": 16.0,
      "paddingVertical": 16.0
    },
    
    "cards": {
      "borderRadius": 12.0,
      "elevation": 2.0,
      "margin": 8.0
    }
  }
}
```

### Propriétés

#### Générales
- `name`: Nom de l'application (pour documentation)
- `className`: Nom de la classe Dart générée
- `outputDir`: Dossier de sortie des fichiers
- `generateExample`: Générer un fichier d'exemple

#### Couleurs
Toutes les couleurs sont en format hexadécimal (`#RRGGBB`):
- `primaryLight/Dark`: Couleurs principales
- `secondaryLight/Dark`: Couleurs secondaires
- `errorLight/Dark`: Couleurs d'erreur
- `surfaceLight/Dark`: Couleurs de surface (optionnel)
- `backgroundLight/Dark`: Couleurs de fond (optionnel)

#### Typographie
- `fontFamily`: Police par défaut
- `customStyles`: Styles personnalisés Material Design 3
   - `fontSize`: Taille en pixels
   - `fontWeight`: `w100` à `w900`
   - `letterSpacing`: Espacement des lettres
   - `height`: Hauteur de ligne

#### Composants
Configuration globale et par composant:
- `borderRadius`: Rayon des bordures
- `elevation`: Élévation des ombres
- `useMaterial3`: Utiliser Material Design 3

## 📁 Structure générée

```
lib/theme/
├── app_theme.dart          # Thème principal
└── theme_example.dart      # Exemple d'utilisation (optionnel)
```

## 🎯 Exemples de configurations

### Thème moderne

```json
{
  "name": "App Moderne",
  "className": "ModernTheme",
  "colors": {
    "primaryLight": "#6366F1",
    "primaryDark": "#818CF8",
    "secondaryLight": "#F59E0B",
    "secondaryDark": "#FCD34D"
  },
  "typography": {
    "fontFamily": "Inter"
  },
  "components": {
    "borderRadius": 16.0,
    "buttons": {
      "elevation": 0.0
    }
  }
}
```

### Thème corporate

```json
{
  "name": "App Corporate",
  "className": "CorporateTheme",
  "colors": {
    "primaryLight": "#1E40AF",
    "primaryDark": "#3B82F6",
    "secondaryLight": "#059669",
    "secondaryDark": "#10B981"
  },
  "components": {
    "borderRadius": 8.0,
    "buttons": {
      "elevation": 2.0
    }
  }
}
```

## 🔧 Workflow de développement

1. **Initialiser**: `dart run dynamic_theme_generator init`
2. **Configurer**: Éditer `theme_config.json`
3. **Développer**: `dart run dynamic_theme_generator generate --watch`
4. **Intégrer**: Importer le thème dans votre app
5. **Itérer**: Modifier la config et voir les changements

## 📱 Hot reload

Le package génère du code Dart standard, compatible avec le hot reload de Flutter. Modifiez votre configuration et régénérez pour voir les changements instantanément.

## 🤝 Contribution

Les contributions sont bienvenues ! N'hésitez pas à:

1. Ouvrir une issue pour signaler un bug
2. Proposer des améliorations
3. Soumettre une pull request

## 📄 Licence

FRANKY MBIELEU License - voir le fichier `LICENSE` pour plus de détails.

---

💡 **Créez des thèmes magnifiques en quelques minutes !**