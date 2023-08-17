import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:notifio_event/core/common/widgets/filled_field.dart';
import 'package:notifio_event/core/common/widgets/widgets.dart';
import 'package:notifio_event/core/utils/core_utils.dart';
import 'package:notifio_event/features/authentication/app/country_code_provider.dart';
import 'package:notifio_event/features/authentication/controller/authentication_controller.dart';

import '../../../core/res/res.dart';

class SignInScreen extends HookConsumerWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final phoneController = useTextEditingController();
    final code = ref.watch(countryCodeProvider);
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: ListView(
          padding:
              const EdgeInsets.symmetric(horizontal: 30).copyWith(bottom: 30),
          physics: const PageScrollPhysics(),
          shrinkWrap: true,
          children: [
            Image.asset(ImageRes.mobileOtpBlue),
            const WhiteSpace(
              height: 20,
            ),
            Text(
              "Please Enter your number to get the verification code",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                color: Colours.greyBackground,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const WhiteSpace(
              height: 30,
            ),
            FilledField(
              keyboardType: TextInputType.phone,
              controller: phoneController,
              readOnly: code == null,
              prefixIcon: Padding(
                padding: const EdgeInsets.only(top: 12, left: 14),
                child: GestureDetector(
                  onTap: () {
                    showCountryPicker(
                      context: context,
                      onSelect: (code) {
                        ref
                            .read(countryCodeProvider.notifier)
                            .changeCountry(code);
                      },
                      countryListTheme: CountryListThemeData(
                        backgroundColor: Colours.light,
                        bottomSheetHeight:
                            MediaQuery.sizeOf(context).height * 0.6,
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(15),
                        ),
                        textStyle: GoogleFonts.poppins(
                            fontSize: 15, fontWeight: FontWeight.w500),
                        searchTextStyle: GoogleFonts.poppins(
                            fontSize: 17, fontWeight: FontWeight.w500),
                      ),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.only(bottom: code == null ? 1.h : 12.h),
                    child: Text(
                      code == null
                          ? "Pick Country"
                          : "${code.flagEmoji} +${code.phoneCode} ",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        color: Colours.light,
                        fontWeight:
                            code == null ? FontWeight.w500 : FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const WhiteSpace(
              height: 30,
            ),
            RoundButton(
              text: "Send Code",
              borderColour: Colours.light,
              onPressed: () async {
                if (code == null) return;
                final navigator = Navigator.of(context);
                CoreUtils.showLoader(context);
                await ref.read(authControllerProvider).sendOTP(
                      context: context,
                      phoneNumber: "+${code.phoneCode}${phoneController.text}",
                    );

                navigator.pop();
              },
              fontWeight: FontWeight.w700,
            )
          ],
        ),
      ),
    ));
  }
}
