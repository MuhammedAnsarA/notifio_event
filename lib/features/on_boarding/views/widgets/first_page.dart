import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/common/widgets/widgets.dart';
import '../../../../core/res/res.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(ImageRes.todoBlue),
          const WhiteSpace(height: 70),
          const FadingText(
            "Get Started with Notifio!",
            textAlign: TextAlign.center,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
          const WhiteSpace(height: 13),
          Text(
            "Organize your life with ease\nStay on top of your tasks and goals",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade800,
            ),
          ),
        ],
      ),
    );
  }
}
