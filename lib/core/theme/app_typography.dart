import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// NEXUS Suite typography system
class AppTypography {
  // Display styles
  static TextStyle displayLarge = GoogleFonts.poppins(
    fontSize: 57,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.25,
  );

  static TextStyle displayMedium = GoogleFonts.poppins(
    fontSize: 45,
    fontWeight: FontWeight.w400,
  );

  static TextStyle displaySmall = GoogleFonts.poppins(
    fontSize: 36,
    fontWeight: FontWeight.w400,
  );

  // Headline styles
  static TextStyle headlineLarge = GoogleFonts.poppins(
    fontSize: 32,
    fontWeight: FontWeight.w600,
  );

  static TextStyle headlineMedium = GoogleFonts.poppins(
    fontSize: 28,
    fontWeight: FontWeight.w600,
  );

  static TextStyle headlineSmall = GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.w600,
  );

  // Title styles
  static TextStyle titleLarge = GoogleFonts.poppins(
    fontSize: 22,
    fontWeight: FontWeight.w500,
  );

  static TextStyle titleMedium = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
  );

  static TextStyle titleSmall = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  );

  // Body styles
  static TextStyle bodyLarge = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
  );

  static TextStyle bodyMedium = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
  );

  static TextStyle bodySmall = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
  );

  // Label styles
  static TextStyle labelLarge = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  );

  static TextStyle labelMedium = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
  );

  static TextStyle labelSmall = GoogleFonts.inter(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
  );

  // Code/monospace
  static TextStyle code = GoogleFonts.firaCode(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );
}
