import 'package:get/get.dart';

class TailorController extends GetxController {
  RxBool isVisible = false.obs;
  RxBool isLogin = true.obs;
  RxBool isAuthentication = false.obs;

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
