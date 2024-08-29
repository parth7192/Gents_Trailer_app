import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/authentication_variable.dart';
import '../../constant/constant_controller.dart';
import '../../constant/constant_string.dart';
import '../../getx/getx.dart';
import '../home_screen.dart';

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
        Get.offAll(() => const HomePageScreen());
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
        Get.offAll(() => const HomePageScreen());
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
        backgroundColor: Colors.redAccent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: size.height * 0.12,
                    child: Image.asset(
                      "assets/images/logo.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    width: size.width * 0.9,
                    child: Form(
                      key: _form,
                      child: Column(
                        children: [
                          Obx(() {
                            if (!_tailorController.isLogin.value) {
                              return Padding(
                                padding:
                                const EdgeInsets.symmetric(vertical: 10.0),
                                child: TextFormField(
                                  controller: usernameController,
                                  decoration: InputDecoration(
                                    hintText: "Username",
                                    filled: true,
                                    fillColor: Colors.grey[200],
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none,
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 20),
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
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: TextFormField(
                              controller: emailController,
                              decoration: InputDecoration(
                                hintText: "Email",
                                filled: true,
                                fillColor: Colors.grey[200],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 20),
                              ),
                              validator: (value) {
                                if (value == null ||
                                    value.trim().isEmpty ||
                                    !value.contains("@")) {
                                  return 'Invalid Email';
                                }
                              },
                              onSaved: (value) {
                                emailController.text = value!;
                              },
                            ),
                          ),
                          Obx(() {
                            return Padding(
                              padding:
                              const EdgeInsets.symmetric(vertical: 10.0),
                              child: TextFormField(
                                obscureText: !_tailorController.isVisible.value,
                                controller: passwordController,
                                decoration: InputDecoration(
                                  hintText: 'Password',
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 20),
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
                                    return 'Password cannot be empty.';
                                  }
                                },
                                onSaved: (value) {
                                  passwordController.text = value!;
                                },
                              ),
                            );
                          }),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Obx(
                                    () => Expanded(
                                  child: TextButton(
                                    onPressed: () {
                                      _tailorController
                                          .login(); // Toggle login/signup
                                    },
                                    child: Text(
                                      _tailorController.isLogin.value
                                          ? "Create Account"
                                          : "Already Have an Account",
                                      style: const TextStyle(
                                          color: Colors.teal, fontSize: 15),
                                    ),
                                  ),
                                ),
                              ),
                              Obx(
                                    () => Expanded(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.teal,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 30),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    onPressed: _submit,
                                    child: Text(
                                      _tailorController.isLogin.value
                                          ? "Login"
                                          : "Signup",
                                      style:
                                      const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
