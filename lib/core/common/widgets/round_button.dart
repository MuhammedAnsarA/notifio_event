import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../res/colours.dart';

class RoundButton extends StatelessWidget {
  const RoundButton({
    Key? key,
    this.onPressed,
    required this.text,
    this.fontWeight,
    this.backgroundColor,
    this.borderColour,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final String text;
  final FontWeight? fontWeight;
  final Color? backgroundColor;
  final Color? borderColour;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? Colours.greyBackground,
        minimumSize: Size(size.width * 0.9, size.height * 0.06),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: borderColour == null
              ? BorderSide.none
              : BorderSide(
                  color: borderColour!,
                ),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: fontWeight ?? FontWeight.bold,
          color: borderColour ?? Colours.light,
        ),
      ),
    );
  }
}
