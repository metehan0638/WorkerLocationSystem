import 'package:worker_location_system/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class MyPasswordTextField extends StatefulWidget {
  const MyPasswordTextField({super.key});

  @override
  State<MyPasswordTextField> createState() => _MyPasswordTextFieldState();
}

class _MyPasswordTextFieldState extends State<MyPasswordTextField> {
  @override
  Widget build(BuildContext context) {
    final loginController = Get.find<LoginController>();

    return TextField(
      
      maxLength: 21,
      cursorColor: Colors.black,
      showCursor: true,
      obscuringCharacter: '*',
      obscureText: loginController.obsuredText.value,
      controller: loginController.pass.value,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(color: Colors.green)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(color: Colors.white)),
        prefixIcon: const Icon(
          Icons.lock,
          color: Colors.black,
          size: 24,
        ),
        filled: true,
        fillColor: HexColor('f3edf5'),
        suffixIcon: loginController.obsuredText.value == false
            ? IconButton(
                onPressed: () {
                  setState(() {
                    loginController.obsuredText.value = true;
                  });
                },
                icon: const Icon(
                  Icons.visibility,
                  color: Colors.black,
                ),
              )
            : IconButton(
                onPressed: () {
                  setState(() {
                    loginController.obsuredText.value = false;
                  });
                },
                icon: const Icon(Icons.visibility_off, color: Colors.black)),
        hintText: 'Şifre',
      ),
    );
  }
}
