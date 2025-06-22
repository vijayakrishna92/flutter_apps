import 'package:flutter/material.dart';
import 'package:vijaya_krishna/widgets/base_page.dart';
import 'package:vijaya_krishna/constants/texts.dart';
import 'package:vijaya_krishna/constants/styles.dart';

class SkillsPage extends StatelessWidget {
  const SkillsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Text(
            skillsText, // 💡 Use the imported text
            style: AppTextStyles.sidebarSectionHeader,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
