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
    fetchOrders();
  }
  void fetchOrders() {
    AuthenticationVar.firestore
        .collection('orders')
        .snapshots()
        .listen((snapshot) {
      registeredOrder.assignAll(snapshot.docs
          .map((doc) {
        print("Fetched Order: ${doc.data()}"); // Add this to see fetched data
        return FirebaseModel.fromFirestore(doc);
      }).toList());
      filteredOrders.assignAll(registeredOrder);
    });
  }


  void addOrder(FirebaseModel order) {
    registeredOrder.add(order);
  }

  void passShow() {
    isVisible.value = !isVisible.value;
  }

  void login() {
    isLogin.value = !isLogin.value;
  }

  void authentication() {
    isAuthentication.value = !isAuthentication.value;
  }
}
