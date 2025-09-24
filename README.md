<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->

TODO: Put a short description of the package here that helps potential users
know whether this package might be useful for them.

## Features# Dynamic Theme Generator

A Flutter package to generate dynamic themes from a JSON configuration file, supporting both light and dark themes with Material 3 design.

## Installation

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  dynamic_theme_generator: ^1.0.0
```

Run `flutter pub get` to install the package.

## Usage

1. Create a `theme_config.json` file in your project root:

```json
{
  "primaryLight": "#1976D2",
  "primaryDark": "#90CAF9",
  "secondaryLight": "#03DAC6",
  "secondaryDark": "#03DAC6",
  "errorLight": "#B00020",
  "errorDark": "#CF6679",
  "surfaceLight": "#FFFBFE",
  "surfaceDark": "#121212",
  "backgroundLight": "#FFFBFE",
  "backgroundDark": "#121212",
  "onPrimaryLight": "#FFFFFF",
  "onPrimaryDark": "#003258",
  "onSurfaceLight": "#1C1B1F",
  "onSurfaceDark": "#E6E1E5",
  "fontFamily": "Roboto",
  "baseFontSize": 16.0
}
```

2. Generate the theme file by running:

```bash
dart run dynamic_theme_generator:generate_theme
```

This will create a `lib/generated_theme.dart` file with `AppTheme` class containing `lightTheme` and `darkTheme`.

3. Use the generated theme in your app:

```dart
import 'package:flutter/material.dart';
import 'generated_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: Scaffold(
        appBar: AppBar(title: const Text('Dynamic Theme App')),
        body: const Center(child: Text('Hello, Dynamic Theme!')),
      ),
    );
  }
}
```

## Command Line

You can specify a custom JSON configuration file:

```bash
dart run dynamic_theme_generator:generate_theme path/to/your_config.json
```

## Example

See the `example/` directory for a complete example demonstrating the use of light and dark themes with various Material 3 components.

TODO: List what your package can do. Maybe include images, gifs, or videos.

## Getting started

TODO: List prerequisites and provide or point to information on how to
start using the package.

## Usage

TODO: Include short and useful examples for package users. Add longer examples
to `/example` folder.

```dart
const like = 'sample';
```

## Additional information

TODO: Tell users more about the package: where to find more information, how to
contribute to the package, how to file issues, what response they can expect
from the package authors, and more.
