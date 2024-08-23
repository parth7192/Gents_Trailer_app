import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gents_trailer/constant/authentication_variable.dart';
import 'package:gents_trailer/constant/constant_controller.dart';
import 'package:gents_trailer/constant/constant_string.dart';
import 'package:gents_trailer/getx/getx.dart';
import 'package:gents_trailer/view/home_screen.dart';
import 'package:get/get.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TailorController _tailorController = Get.put(TailorController());
  final _form = GlobalKey<FormState>();

  void _submit() async {
    final isValid = _form.currentState!.validate();

    if (!isValid) {
      return;
    }
    _form.currentState!.save();

    try {
      _tailorController.isAuthentication.value = true;
      if (_tailorController.isLogin.value) {
        // For login
        final userCredentials =
            await AuthenticationVar.firebase.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        print("$loginSuccessful: ${userCredentials.user?.email}");
        // Navigate to Home Screen
        Get.to(() => const HomePageScreen());
      } else {
        // For signup
        final userCredentials =
            await AuthenticationVar.firebase.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        // Store additional user info
        await FirebaseFirestore.instance.collection("users").add({
          'email': emailController.text,
          'UserName': usernameController.text,
        });
        print("$signupSuccessful: ${userCredentials.user?.email}");
        // Navigate to Home Screen
        Get.to(() => const HomePageScreen());
      }
    } on FirebaseAuthException catch (error) {
      // Error handling
      if (_tailorController.isLogin.value) {
        if (error.code == 'user-not-found') {
          _showErrorSnackBar(context, noAccountFound);
        } else if (error.code == 'wrong-password') {
          _showErrorSnackBar(context, wrongPassword);
        } else {
          _showErrorSnackBar(context, loginFailed);
        }
      } else {
        if (error.code == 'email-already-in-use') {
          _showErrorSnackBar(context, emailInUse);
        } else {
          _showErrorSnackBar(context, signupFailed);
        }
      }
      _tailorController.isAuthentication.value = false;
    }
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 50),
            SizedBox(
              width: 150,
              height: 150,
              child: Image.asset("assets/images/suit.png"),
            ),
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                width: 500, // Set the width explicitly
                child: Image.asset(
                  "assets/images/logo.jpg",
                  fit: BoxFit.cover, // This can help fill the area
                ),
              ),
            ),
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.only(left: 42.0, right: 30.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black45,
                  borderRadius: BorderRadius.circular(20),
                ),
                width: size.width * 0.8,
                height: size.height * 0.4,
                child: Form(
                  key: _form,
                  child: Column(
                    children: [
                      const SizedBox(height: 15),
                      Obx(() {
                        // If the user is not logged in, show the Username TextFormField
                        if (!_tailorController.isLogin.value) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: TextFormField(
                              controller: usernameController,
                              decoration: InputDecoration(
                                hintText: "Username",
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              validator: (value) {
                                if (value == null ||
                                    value.trim().isEmpty ||
                                    value.length < 4) {
                                  return 'Name must be at least 4 characters long.';
                                }
                              },
                              onSaved: (value) {
                                usernameController.text = value!;
                              },
                            ),
                          );
                        } else {
                          return const SizedBox(); // Empty widget when user is logged in (or some other UI element)
                        }
                      }),
                      const SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            hintText: "Email",
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          validator: (value) {
                            if (value == null ||
                                value.trim().isEmpty ||
                                !value.contains("@gmail.com")) {
                              return 'Invalid Email';
                            }
                          },
                          onSaved: (value) {
                            emailController.text = value!;
                          },
                        ),
                      ),
                      const SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Obx(() {
                          return TextFormField(
                            obscureText: !_tailorController.isVisible.value,
                            controller: passwordController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none,
                              ),
                              hintText: 'Password',
                              filled: true,
                              fillColor: Colors.white,
                              suffixIcon: IconButton(
                                onPressed: _tailorController.passShow,
                                icon: Icon(
                                  _tailorController.isVisible.value
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Name must be at least 4 characters long.';
                              }
                            },
                            onSaved: (value) {
                              usernameController.text = value!;
                            },
                          );
                        }),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 13, right: 13),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Obx(
                              () => TextButton(
                                onPressed: () {
                                  _tailorController
                                      .login(); // Call login method here
                                },
                                child: Text(
                                  _tailorController.isLogin.value
                                      ? "Create Account"
                                      : "Already Account",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                              ),
                            ),
                            Obx(
                              () => ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      WidgetStateProperty.all(Colors.black),
                                ),
                                onPressed: () {
                                  _submit();
                                },
                                child: Text(
                                  _tailorController.isLogin.value
                                      ? "Login"
                                      : "Signup",
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
