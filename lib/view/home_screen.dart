import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gents_trailer/constant/authentication_variable.dart';
import 'package:gents_trailer/getx/getx.dart';
import 'package:gents_trailer/view/auth/authentication.dart';
import 'package:gents_trailer/view/new_order.dart';
import 'package:get/get.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  void logout() {
    AuthenticationVar.firebase.signOut();
  }

  TailorController tailorController = Get.put(TailorController());

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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => NewOrder(
                      onAddOrder: tailorController.addOrder,
                    )));
          },
          child: const Icon(Icons.add),
        ));
  }
}
