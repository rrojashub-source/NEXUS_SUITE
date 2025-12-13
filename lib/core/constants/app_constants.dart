/// Application-wide constants
library;

class AppConstants {
  AppConstants._();

  // ============================================
  // Animation Durations
  // ============================================

  static const Duration animationFast = Duration(milliseconds: 150);
  static const Duration animationNormal = Duration(milliseconds: 300);
  static const Duration animationSlow = Duration(milliseconds: 500);

  // ============================================
  // Spacing
  // ============================================

  static const double spacingXs = 4.0;
  static const double spacingSm = 8.0;
  static const double spacingMd = 16.0;
  static const double spacingLg = 24.0;
  static const double spacingXl = 32.0;
  static const double spacingXxl = 48.0;

  // ============================================
  // Border Radius
  // ============================================

  static const double radiusSm = 4.0;
  static const double radiusMd = 8.0;
  static const double radiusLg = 12.0;
  static const double radiusXl = 16.0;
  static const double radiusCircle = 999.0;

  // ============================================
  // Icon Sizes
  // ============================================

  static const double iconSm = 16.0;
  static const double iconMd = 24.0;
  static const double iconLg = 32.0;
  static const double iconXl = 48.0;

  // ============================================
  // Pagination
  // ============================================

  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;
}
