import 'package:flutter/material.dart';

class AppColor {
  // ========== PRIMARY COLORS ==========
  static const primary = Color(0xFF2DD4BF);
  static const primaryLight = Color(0xFFCCFBF1);
  static const primaryMedium = Color(0xFF30C0B0);
  static const primaryBright = Color(0xFF40E0D0);
  static const primaryDark = Color(0xFF0F766E);

  // ========== BASE COLORS ==========
  static const white = Color(0xFFFFFFFF);
  static const background = Color(0xFFF7F7FC);
  static const black = Color(0xFF1C1F28);
  static const blackPure = Color(0xFF000000);

  // ========== NEUTRAL COLORS ==========
  static const silver = Color(0xFFEDF1F3);
  static const gray = Color(0xFFACB5BB);
  static const grayLight = Color(0xFFE5E7EB);
  static const grayDark = Color(0xFF6C7278);

  // ========== SEMANTIC COLORS ==========
  static const success = Color(0xFF10B981);
  static const error = Color(0xFFEF4444);
  static const warning = Color(0xFFF59E0B);
  static const info = Color(0xFF3B82F6);

  // ========== UI COLORS ==========
  static const blue = Color(0xFF3B82F6);
  static const green = Color(0xFF10B981);
  static const purple = Color(0xFFA855F7);
  static const orange = Color(0xFFF97316);
  static const pink = Color(0xFFEC4899);
  static const red = Color(0xFFDC2626);
  static const yellow = Color(0xFFF59E0B);
  static const orangeLight = Color(0xFFFF8803);
  static const orangeDark = Color(0xFFFF6800);
  static const purpleLight = Color(0xFFAD46FF);
  static const purpleDark = Color(0xFF9810FA);
  static const greenLight = Color(0xFF00C850);
  static const greenDark = Color(0xFF00A63D);
  static const blueLight = Color(0xFF2B7FFF);
  static const blueDark = Color(0xFF155CFB);
  static const amberDark = Color(0xFFD08700);
  static const yellowSoft = Color(0xFFFEF9C2);

  // ========== TEXT COLORS ==========
  static const textPrimary = Color(0xFF1C1F28);
  static const textSecondary = Color(0xFF6C7278);
  static const textDisabled = Color(0xFFACB5BB);
  static const textHint = Color(0xFFD1D5DB);

  // ========== BORDER COLORS ==========
  static const border = Color(0xFFE5E7EB);
  static const borderFocus = Color(0xFF2DD4BF);
  static const borderError = Color(0xFFEF4444);

  // ========== TRANSPARENT VARIANTS ==========
  static final primaryTransparent = primary.withOpacity(0.1);
  static final successTransparent = success.withOpacity(0.1);
  static final errorTransparent = error.withOpacity(0.1);
  static final warningTransparent = warning.withOpacity(0.1);
  static final infoTransparent = info.withOpacity(0.1);
  static final purpleTransparent = purple.withOpacity(0.1);

  // ========== OVERLAY ==========
  static final overlay = blackPure.withOpacity(0.5);
  static final overlayLight = blackPure.withOpacity(0.2);

  // ========== SHADOW ==========
  static final shadow = black.withOpacity(0.08);
  static final shadowMedium = black.withOpacity(0.12);
  static final shadowDark = black.withOpacity(0.15);

  // ========== DISABLED STATE ==========
  static final disabledButton = primary.withOpacity(0.5);
  static const disabledText = Color(0xFFACB5BB);
  static const disabledBackground = Color(0xFFF3F4F6);

  // ========== GRADIENT PRESETS ==========

  /// Diagonal gradient (top-left to bottom-right)
  static LinearGradient gradientDiagonal(Color start, Color end) {
    return LinearGradient(
      colors: [start, end],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }

  /// Horizontal gradient (left to right)
  static LinearGradient gradientHorizontal(Color start, Color end) {
    return LinearGradient(
      colors: [start, end],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    );
  }

  /// Vertical gradient (top to bottom)
  static LinearGradient gradientVertical(Color start, Color end) {
    return LinearGradient(
      colors: [start, end],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );
  }

  /// Radial gradient (center to outside)
  static RadialGradient gradientRadial(Color start, Color end) {
    return RadialGradient(
      colors: [start, end],
      center: Alignment.center,
    );
  }
}