import 'package:flutter/material.dart';
import 'package:vijaya_krishna/constants/colors.dart';
import 'package:vijaya_krishna/constants/sizes.dart';
import 'package:vijaya_krishna/constants/styles.dart';
import 'package:vijaya_krishna/constants/texts.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  //app bar
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(
        AppSizes.appBarHeight +
            AppSizes.appBarTopMargin +
            8, // height + top margin + bottom margin
      ),
      child: Container(
        height: AppSizes.appBarHeight,
        margin: EdgeInsets.only(
          top: AppSizes.appBarTopMargin,
          left: 12,
          right: 12,
          bottom: 8,
        ),
        decoration: BoxDecoration(
          color: AppColors.appBackground,
          borderRadius: BorderRadius.circular(AppSizes.appBarBorderRadius),
          boxShadow: [
            BoxShadow(
              color: AppColors.appBarShadow,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // The centered title
            const Text(myName, style: AppTextStyles.appBarTitle),

            // The sidebar icon positioned to the left
            Positioned(left: 0, child: buildSidebarIcon(context)),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(AppSizes.appBarHeight + AppSizes.appBarTopMargin + 8);

  //sidebar
  Widget buildSidebarIcon(BuildContext context) {
    return Builder(
      builder:
          (context) => IconButton(
            icon: const Icon(Icons.menu),
            color: AppColors.appText,
            iconSize: 28,
            onPressed: () {
              Scaffold.of(context).openDrawer(); // This will now work.
            },
          ),
    );
  }
}
