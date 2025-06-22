import 'package:flutter/material.dart';
import 'colors.dart';

Widget buildSidebarDivider() {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 6), // Space around divider
    height: 1,
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [
          AppColors.textDivider, // Start color (light grey)
          AppColors.textFader, // Fade out to transparent
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
    ),
  );
}

class AppTextStyles {
  static const TextStyle appBarTitle = TextStyle(
    color: AppColors.appText,
    fontSize: 22,
    fontWeight: FontWeight.w600,
  );
  static const TextStyle sidebarAppName = TextStyle(
    color: AppColors.appText,
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle sidebarItem = TextStyle(
    color: AppColors.appText,
    fontSize: 20,
  );
  static const TextStyle sidebarSectionHeader = TextStyle(
    color: AppColors.appText,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
  static BoxDecoration cloudyBackground = BoxDecoration(
    color: AppColors.appBackground, // You can change opacity if needed
    borderRadius: BorderRadius.circular(12),
  );
}
