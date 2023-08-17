import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notifio_event/core/res/colours.dart';

class CoreUtils {
  const CoreUtils._();

  static void showSnackBar(
      {required BuildContext context, required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(
        message,
        style: GoogleFonts.poppins(
          fontSize: 14,
          color: Colours.light,
          fontWeight: FontWeight.w600,
        ),
      )),
    );
  }

  static void showLoader(BuildContext context, {String? message}) {
    showDialog(
      context: context,
      builder: (_) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(color: Colors.lightBlueAccent),
            if (message != null)
              Text(
                "$message...",
                style: GoogleFonts.poppins(color: Colors.lightBlueAccent),
              ),
          ],
        ),
      ),
    );
  }
}
