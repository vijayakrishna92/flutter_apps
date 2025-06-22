import 'package:flutter/material.dart';
import 'package:vijaya_krishna/widgets/base_page.dart';
import 'package:vijaya_krishna/constants/styles.dart';
import 'package:vijaya_krishna/constants/texts.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Text(
            aboutMe,
            style: AppTextStyles.sidebarSectionHeader,
            textAlign: TextAlign.center, // Center the text
          ),
        ),
      ),
    );
  }
}
