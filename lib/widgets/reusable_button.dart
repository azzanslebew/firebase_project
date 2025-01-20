import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReusableButton extends StatelessWidget {
  final VoidCallback onPressed;
  final double borderRadius;
  final double elevation;
  final Color backgroundColor;
  final Color textColor;
  final String category;
  final bool isSelected;
  final bool showIcon;
  final IconData? icon;
  final Widget? iconWidget;
  final bool showBorder;
  final bool useSizedBox;
  final bool isIconLeft;
  final double iconSize;

  const ReusableButton({
    super.key,
    required this.onPressed,
    this.borderRadius = 8.0,
    this.elevation = 0.0,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black,
    required this.category,
    this.isSelected = false,
    this.showIcon = false,
    this.icon,
    this.iconWidget,
    this.showBorder = true,
    this.useSizedBox = false,
    this.isIconLeft = false,
    this.iconSize = 24.0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: showBorder
                ? BorderSide(
                    color: isSelected ? Colors.transparent : Colors.blueAccent,
                  )
                : BorderSide.none,
          ),
          backgroundColor: isSelected ? Colors.black : backgroundColor,
          foregroundColor: isSelected ? Colors.white : textColor,
          elevation: elevation,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isIconLeft && showIcon)
              iconWidget ??
                  (icon != null
                      ? Icon(icon, size: iconSize, color: textColor)
                      : const SizedBox()),
            Text(
              category,
              style: GoogleFonts.manrope(
                  color: isSelected ? Colors.white : textColor),
            ),
            if (useSizedBox)
              const SizedBox(
                width: 10,
              ),
            if (!isIconLeft && showIcon)
              iconWidget ??
                  (icon != null
                      ? Icon(icon, size: iconSize, color: textColor)
                      : const SizedBox()),
          ],
        ),
      ),
    );
  }
}
