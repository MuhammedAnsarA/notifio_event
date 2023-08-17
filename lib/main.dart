import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:notifio_event/features/authentication/app/user_provider.dart';
import 'package:notifio_event/firebase_options.dart';

import 'features/on_boarding/onboarding.dart';
import 'features/todo/view/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScreenUtilInit(
      designSize: const Size(411.4, 867.4),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          title: 'Notifio Event',
          theme: ThemeData(
            colorScheme:
                ColorScheme.fromSeed(seedColor: Colors.lightBlueAccent),
            scaffoldBackgroundColor: Colors.white,
            useMaterial3: true,
          ),
          debugShowCheckedModeBanner: false,
          home: ref.watch(userProvider).when(
            data: (userExists) {
              if (userExists) {
                return const HomeScreen();
              } else {
                return const OnBoardingScreen();
              }
            },
            error: (error, stackTrace) {
              debugPrint("ERROR: $error");
              debugPrint(stackTrace.toString());
              return const OnBoardingScreen();
            },
            loading: () {
              return const Scaffold(
                  body: Center(
                child: CircularProgressIndicator(),
              ));
            },
          ),
        );
      },
    );
  }
}
