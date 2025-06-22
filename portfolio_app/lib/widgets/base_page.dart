import 'package:flutter/material.dart';
import 'package:vijaya_krishna/pages/home_page.dart';
import 'package:vijaya_krishna/pages/about_page.dart';
import 'package:vijaya_krishna/pages/skills_page.dart';
import 'package:vijaya_krishna/pages/projects_page.dart';
import 'package:vijaya_krishna/pages/contact_page.dart';
import 'package:vijaya_krishna/constants/texts.dart';
import 'package:vijaya_krishna/widgets/custom_app_bar.dart';
import 'package:vijaya_krishna/constants/colors.dart';
import 'package:vijaya_krishna/constants/sizes.dart';
import 'package:vijaya_krishna/constants/styles.dart';
import 'package:vijaya_krishna/constants/links.dart';
import 'package:url_launcher/url_launcher.dart';

Widget buildSocialIcon(String imagePath, String url) {
  return GestureDetector(
    onTap: () async {
      final Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } 
    },
    child: Image.asset(imagePath, width: 30, height: 30),
  );
}

class BasePage extends StatelessWidget {
  final Widget child;

  const BasePage({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: buildSidebar(context), // Pass context here
      appBar: const CustomAppBar(),
      body: child,
    );
  }

  /// 🔹 Sidebar with Navigation
  Drawer buildSidebar(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔹 App Name Header
          Container(
            width: double.infinity,
            color: AppColors.appBackground,
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: SizedBox(
              height: 120,
              child: const Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: Text(
                    myName,
                    style: AppTextStyles.sidebarAppName,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // 🔸 Section: Navigation
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Navigation', style: AppTextStyles.sidebarSectionHeader),
                const SizedBox(height: 10),
                buildSidebarItem(context, 'Home', const HomePage()),
                buildSidebarDivider(),
                buildSidebarItem(context, 'About', const AboutPage()),
                buildSidebarDivider(),
                buildSidebarItem(context, 'Skills', const SkillsPage()),
                buildSidebarDivider(),
                buildSidebarItem(context, 'Projects', const ProjectsPage()),
                buildSidebarDivider(),
                buildSidebarItem(context, 'Contact', const ContactPage()),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // 🔸 Section: Social Media
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text('Social', style: AppTextStyles.sidebarSectionHeader),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildSocialIcon('assets/icons/dagshub.png', AppLinks.dagshub),
                buildSocialIcon('assets/icons/linkedin.png', AppLinks.linkedin),
                buildSocialIcon('assets/icons/github.png', AppLinks.github),
                buildSocialIcon('assets/icons/gmail.png', AppLinks.gmail),
                buildSocialIcon(
                  'assets/icons/telephone.png',
                  AppLinks.telephone,
                ),
                buildSocialIcon('assets/icons/whatsapp.png', AppLinks.whatsapp),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 🔹 Reusable Sidebar Item with Navigation
  Widget buildSidebarItem(
    BuildContext context,
    String title,
    Widget targetPage,
  ) {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.sidebarItemPadding),
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context); // Close the sidebar
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => targetPage),
          );
        },
        child: Text(title, style: AppTextStyles.sidebarItem),
      ),
    );
  }
}
