import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReusableAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showIcon;
  final double fontSize;
  final Color titleColor;
  final Color backgroundColor;

  const ReusableAppBar({
    super.key,
    required this.title,
    this.showIcon = true,
    required this.fontSize,
    this.titleColor = const Color(0xff404040),
    this.backgroundColor = const Color(0xffF5F5F5), // Default putih
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      backgroundColor: backgroundColor,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.manrope(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: titleColor,
            ),
          ),
          if (showIcon)
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications_outlined,
                color: Colors.white,
              ),
            ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
