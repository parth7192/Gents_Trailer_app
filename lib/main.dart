import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gents_trailer/firebase_options.dart';
import 'package:gents_trailer/my_app/my_app.dart';
import 'package:get/get.dart';

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
