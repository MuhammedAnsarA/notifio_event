// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pinput/pinput.dart';

import 'package:notifio_event/core/common/widgets/widgets.dart';
import 'package:notifio_event/features/authentication/controller/authentication_controller.dart';

import '../../../core/res/res.dart';
import '../../../core/utils/core_utils.dart';

class OTPVerificationScreen extends ConsumerWidget {
  const OTPVerificationScreen({
    super.key,
    required this.verificationId,
  });

  final String verificationId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 30).copyWith(bottom: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(ImageRes.otpBlue),
              const WhiteSpace(
                height: 60,
              ),
              Pinput(
                length: 6,
                onCompleted: (pin) async {
                  CoreUtils.showLoader(context);
                  await ref.read(authControllerProvider).verifyOTP(
                        context: context,
                        verificationId: verificationId,
                        otp: pin,
                      );
                },
                defaultPinTheme: PinTheme(
                  textStyle: const TextStyle(
                    color: Colours.light,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 17,
                  ),
                  decoration: BoxDecoration(
                    color: Colours.greyBackground,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
