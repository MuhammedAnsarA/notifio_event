import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:notifio_event/core/helper/db_helper.dart';
import 'package:notifio_event/core/utils/core_utils.dart';
import 'package:notifio_event/features/authentication/views/otp_verification_screen.dart';
import 'package:notifio_event/features/todo/view/home_screen.dart';

final authRepoProvider =
    Provider((ref) => AuthenticationRepository(auth: FirebaseAuth.instance));

class AuthenticationRepository {
  const AuthenticationRepository({required this.auth});

  final FirebaseAuth auth;

  Future<void> sendOTP({
    required BuildContext context,
    required String phoneNumber,
  }) async {
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (credential) {
        auth.signInWithCredential(credential);
      },
      verificationFailed: (exception) {
        CoreUtils.showSnackBar(
            context: context,
            message: "${exception.code}: ${exception.message}");
      },
      codeSent: (verificationId, _) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                OTPVerificationScreen(verificationId: verificationId),
          ),
        );
      },
      codeAutoRetrievalTimeout: (verificationId) {},
    );
  }

  Future<void> verifyOTP({
    required BuildContext context,
    required String verificationId,
    required String otp,
  }) async {
    try {
      void showSnack(String message) =>
          CoreUtils.showSnackBar(context: context, message: message);

      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );

      final navigator = Navigator.of(context);
      final userCredential = await auth.signInWithCredential(credential);
      if (userCredential.user != null) {
        await DBHelper.createUSer(isVerified: true);
        navigator.pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const HomeScreen()),
          (route) => false,
        );
      } else {
        showSnack("Error Occurred, Failed to Sign Up User");
      }
    } on FirebaseException catch (e) {
      CoreUtils.showSnackBar(
        context: context,
        message: "${e.code}: ${e.message}",
      );
    } catch (e) {
      CoreUtils.showSnackBar(
        context: context,
        message: "505: Error Occured, Faild to Sign User",
      );
    }
  }
}
