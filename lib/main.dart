import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';
import 'package:telfood/firebase_options.dart';
import 'package:telfood/helper/app_colors.dart';
import 'package:telfood/helper/dismissable_keyboard.dart';
import 'package:telfood/helper/navigators.dart';
import 'package:telfood/screen/sign_in_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting("id");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DismissableKeyboard(
      child: MaterialApp(
        title: 'Telfood',
        debugShowCheckedModeBanner: false,
        navigatorKey: Navigators.navigatorState,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.yellow),
          useMaterial3: true,
        ),
        home: SignInScreen(),
      ),
    );
  }
}