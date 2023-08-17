// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../res/colours.dart';

class FilledField extends StatelessWidget {
  const FilledField({
    Key? key,
    this.controller,
    this.readOnly = false,
    this.prefixIcon,
    this.suffixIcon,
    this.hintText,
    this.hintStyle,
    this.keyboardType,
  }) : super(key: key);

  final TextEditingController? controller;
  final bool readOnly;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? hintText;
  final TextStyle? hintStyle;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: GoogleFonts.poppins(
        fontSize: 17,
        color: Colours.light,
        fontWeight: FontWeight.w500,
      ),
      controller: controller,
      readOnly: readOnly,
      onTapOutside: (_) {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      decoration: InputDecoration(
        filled: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        fillColor: Colours.greyBackground,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintText: hintText,
        hintStyle: hintStyle,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
      ),
      keyboardType: keyboardType,
    );
  }
}
