import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gents_trailer/view/auth/authentication.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  final FirebaseAuth _firebase = FirebaseAuth.instance;

  void logout() {
    _firebase.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          IconButton(
              onPressed: () {
                logout();
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const AuthScreen(),
                ));
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Container(),
    );
  }
}
