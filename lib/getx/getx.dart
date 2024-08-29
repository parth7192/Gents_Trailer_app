import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant/authentication_variable.dart';
import '../model/firebase_model.dart';

class TailorController extends GetxController {
  RxBool isVisible = false.obs;
  RxBool isLogin = true.obs;
  late RxList<FirebaseModel> filteredOrders;
  RxBool isAuthentication = false.obs;
  late RxList<FirebaseModel> registeredOrder;

  @override
  void onInit() {
    super.onInit();
    registeredOrder = <FirebaseModel>[].obs;
    filteredOrders = <FirebaseModel>[].obs;
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        // User is logged in, fetch their orders
        fetchOrders();
      } else {
        // User is logged out, clear the order list
        print("User is logged out");
        registeredOrder.clear();
        filteredOrders.clear();
      }
    });
  }

  void fetchOrders() {
    var currentUser = AuthenticationVar.firebase.currentUser;
    if (currentUser == null) {
      print("User is not logged in");
      return;
    }

    AuthenticationVar.firestore
        .collection('order')
        .doc(currentUser.email)
        .collection('orders')
        .snapshots()
        .listen((snapshot) {
      registeredOrder.assignAll(snapshot.docs.map((doc) {
        print("Fetched Order: ${doc.data()}");
        return FirebaseModel.fromFirestore(doc);
      }).toList());
      filteredOrders.assignAll(registeredOrder);
    });
  }


  void addOrder(FirebaseModel order) {
    registeredOrder.add(order);
  }

  void removeOrder(FirebaseModel order) async {
    try {
      // Remove the order from Firestore using its document ID
      await AuthenticationVar.firestore
          .collection('order')
          .doc(AuthenticationVar.firebase.currentUser!.email)
          .collection('orders')
          .doc(order.id)
          .delete();

      // Remove the order from the filteredOrders list after successful deletion
      filteredOrders.remove(order);

      // Show a snackbar to confirm deletion
      Get.snackbar(
        "Order deleted",
        "",
        duration: const Duration(seconds: 3),
        snackPosition: SnackPosition.BOTTOM,
        mainButton: TextButton(
          onPressed: () {
            // Re-add the order to the list if Undo is pressed
            filteredOrders.add(order);

            // Optionally, re-add the order back to Firestore if needed
            AuthenticationVar.firestore
                .collection('order')
                .doc(AuthenticationVar.firebase.currentUser!.email)
                .collection('orders')
                .doc(order.id)
                .set(order.toMap()); // Convert your model to a Map

            Get.back();
          },
          child: const Text("Undo"),
        ),
      );
    } catch (e) {
      // Handle any errors
      Get.snackbar(
        "Error",
        "Failed to delete the order: $e",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void passShow() {
    isVisible.value = !isVisible.value;
  }

  void login() {
    isLogin.value = !isLogin.value;
  }
}
