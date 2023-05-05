import 'package:worker_location_system/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class MyUsernameTextField extends StatefulWidget {
  const MyUsernameTextField({super.key});

  @override
  State<MyUsernameTextField> createState() => _MyUsernameTextFieldState();
}

class _MyUsernameTextFieldState extends State<MyUsernameTextField> {
  @override
  Widget build(BuildContext context) {
    final loginController = Get.find<LoginController>();
    return Obx(() => TextField(
          showCursor: true,
          autofocus: false,
          cursorColor: Colors.black,
          controller: loginController.user.value,
          onChanged: (user) {
            setState(() {});
          },
          decoration: InputDecoration(
            prefixIcon: const Icon(
              Icons.supervised_user_circle,
              color: Colors.black,
              size: 24,
            ),
            filled: true,
            fillColor: HexColor('#f3edf5'),
            suffixIcon: loginController.user.value.text.isEmpty
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        return;
                      });
                    },
                    icon: Container())
                : IconButton(
                    onPressed: () {
                      setState(() {
                        loginController.user.value.clear();
                      });
                    },
                    icon: const Icon(Icons.clear)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: const BorderSide(color: Colors.green)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: const BorderSide(color: Colors.white)),
            hintStyle: const TextStyle(color: Colors.black45),
            hintText: 'Kullanıcı Adı',
          ),
        ));
  }
}
