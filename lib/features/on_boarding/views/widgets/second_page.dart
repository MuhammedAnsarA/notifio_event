import 'package:flutter/material.dart';
import 'package:notifio_event/features/authentication/views/sign_in_screen.dart';

import '../../../../core/common/widgets/widgets.dart';
import '../../../../core/res/res.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(ImageRes.todoBlue),
          const WhiteSpace(height: 170),
          RoundButton(
            text: "Login with mobile number",
            borderColour: Colours.light,
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => const SignInScreen(),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
