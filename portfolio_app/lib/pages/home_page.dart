import 'package:flutter/material.dart';
import 'package:vijaya_krishna/widgets/base_page.dart';
import 'package:vijaya_krishna/constants/styles.dart';
import 'package:vijaya_krishna/constants/texts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      child: Stack(
        children: [
          // Scrollable Background Image
          SingleChildScrollView(
            child: Column(
              children: [
                Image.asset('assets/images/app_icon.png', fit: BoxFit.cover),
                // Optional extra scroll space
              ],
            ),
          ),

          // Text at the bottom of the image
          Positioned(
            bottom: 20, // Distance from the bottom of the screen
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: AppTextStyles.cloudyBackground,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                Text(
                  myTitle,
                  style: AppTextStyles.sidebarAppName,
                ),
                Text(
                  myDescription,
                  style: AppTextStyles.sidebarSectionHeader,
                  textAlign: TextAlign.center,
                ),
                  ]
                )
              ),
            ),
          ),
        ],
      ),
    );
  }
}
