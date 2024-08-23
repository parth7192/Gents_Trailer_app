import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gents_trailer/firebase_options.dart';
import 'package:gents_trailer/view/auth/authentication.dart';
import 'package:gents_trailer/view/home_screen.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      title: 'Gents Tailor',
      home: const AuthScreen(), // Set the initial screen
      getPages: [
        GetPage(
          name: '/',
          page: () => const HomePageScreen(),
        ),
        GetPage(
          name: '/',
          page: () => const AuthScreen(),
        ),
      ],
    );
  }
}
