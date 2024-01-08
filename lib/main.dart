import 'package:fawatery_user/Screens/MainScreen/main_screen.dart';
import 'package:fawatery_user/Shared/Constants/constant_strings.dart';
import 'package:fawatery_user/Shared/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'Screens/IntroScreen/intro_screen.dart';
import 'Shared/Components/text_style.dart';
import 'Shared/Constants/app_colors.dart';
import 'Shared/container_injection.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initKiwi();
  Future.wait([InitStorage.readAll()]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, _) {
        return GetMaterialApp(
          showSemanticsDebugger: false,
            title: 'Fatoura User',
            locale: const Locale('ar', 'EG'),
            theme: ThemeData(
              appBarTheme: AppBarTheme(
                  backgroundColor: Colors.white,
                  titleTextStyle: textStyle(size: 16, weight: FontWeight.w500),
                  centerTitle: true),
              scrollbarTheme: const ScrollbarThemeData().copyWith(
                thumbColor:
                    MaterialStateProperty.all(AppColors.ffF05A27OrangeColor),
                trackColor:
                    MaterialStateProperty.all(AppColors.ffFEEFE9PrimaryLight),
              ),
              scaffoldBackgroundColor: Colors.white,
              colorScheme: ColorScheme.fromSeed(
                  seedColor: AppColors.ffF05A27OrangeColor),
              useMaterial3: true,
            ),
            home: _);
      },
      child: FutureBuilder(
          future: InitStorage.storage.read(key: AppStrings.storageTokenKey),
          builder: (context, snapshot) {
            return snapshot.hasData ? const MainScreen() : const IntroScreen();
          }),
    );
  }
}
