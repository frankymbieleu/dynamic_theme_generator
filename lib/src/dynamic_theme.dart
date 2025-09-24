import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';

class ThemeConfig {
  final Color primaryLight;
  final Color primaryDark;
  final Color secondaryLight;
  final Color secondaryDark;
  final Color errorLight;
  final Color errorDark;
  final Color surfaceLight;
  final Color surfaceDark;
  final Color backgroundLight;
  final Color backgroundDark;
  final Color onPrimaryLight;
  final Color onPrimaryDark;
  final Color onSurfaceLight;
  final Color onSurfaceDark;
  final String fontFamily;
  final double baseFontSize;

  ThemeConfig({
    required this.primaryLight,
    required this.primaryDark,
    required this.secondaryLight,
    required this.secondaryDark,
    required this.errorLight,
    required this.errorDark,
    required this.surfaceLight,
    required this.surfaceDark,
    required this.backgroundLight,
    required this.backgroundDark,
    required this.onPrimaryLight,
    required this.onPrimaryDark,
    required this.onSurfaceLight,
    required this.onSurfaceDark,
    this.fontFamily = 'Roboto',
    this.baseFontSize = 16.0,
  });

  factory ThemeConfig.fromJson(Map<String, dynamic> json) {
    return ThemeConfig(
      primaryLight: _parseColor(json['primaryLight']),
      primaryDark: _parseColor(json['primaryDark']),
      secondaryLight: _parseColor(json['secondaryLight']),
      secondaryDark: _parseColor(json['secondaryDark']),
      errorLight: _parseColor(json['errorLight']),
      errorDark: _parseColor(json['errorDark']),
      surfaceLight: _parseColor(json['surfaceLight']),
      surfaceDark: _parseColor(json['surfaceDark']),
      backgroundLight: _parseColor(json['backgroundLight']),
      backgroundDark: _parseColor(json['backgroundDark']),
      onPrimaryLight: _parseColor(json['onPrimaryLight']),
      onPrimaryDark: _parseColor(json['onPrimaryDark']),
      onSurfaceLight: _parseColor(json['onSurfaceLight']),
      onSurfaceDark: _parseColor(json['onSurfaceDark']),
      fontFamily: json['fontFamily'] ?? 'Roboto',
      baseFontSize: (json['baseFontSize'] ?? 16.0).toDouble(),
    );
  }

  static Color _parseColor(String hex) {
    final cleanHex = hex.replaceAll('#', '');
    return Color(int.parse('FF$cleanHex', radix: 16));
  }
}