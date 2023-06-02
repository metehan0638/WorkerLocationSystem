import 'package:worker_location_system/constants/const.dart';
import 'package:worker_location_system/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  RxBool obsuredText = true.obs;
  Rx<TextEditingController> user = TextEditingController().obs;
  Rx<TextEditingController> pass = TextEditingController().obs;
  void successfulLogin() async {
    Get.defaultDialog(
      barrierDismissible: false,
      titleStyle:
          const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      backgroundColor: Colors.green,
      title: 'Başarılı Giriş',
      content: SizedBox(
          height: 150,
          width: 150,
          child: Container(
              decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.circular(12)),
              child: Image.asset(Constants.successfulLoginUrl))),
    );
    await Future.delayed(const Duration(seconds: 2));
    Get.offAndToNamed(Routes.WORKER_LIST_PAGE);
    user.value.clear();
    pass.value.clear();
  }

  void unSuccessfulLogin() {
    Get.defaultDialog(
      barrierDismissible: false,
      titleStyle:
          const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      title: 'Başarısız Giriş Denemesi',
      backgroundColor: Colors.red,
      actions: [
        TextButton(
            style: TextButton.styleFrom(backgroundColor: Colors.white),
            onPressed: () {
              pass.value.clear();
              user.value.clear();
              Get.back();
            },
            child: const Text('Geri')),
      ],
      content: SizedBox(
          height: 150,
          width: 150,
          child: SizedBox(child: Image.asset("lib/assets/failed.gif"))),
    );
  }
}
