import 'package:gents_trailer/constant/authentication_variable.dart';
import 'package:gents_trailer/model/firebase_model.dart';
import 'package:get/get.dart';

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
        .where('userId', isEqualTo: AuthenticationVar.firebase.currentUser?.uid)
        .snapshots()
        .listen((snapshot) {
      registeredOrder.assignAll(snapshot.docs
          .map((doc) => FirebaseModel.fromFirestore(doc))
          .toList());
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
