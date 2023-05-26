import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:worker_location_system/controllers/login_controller.dart';
import 'package:worker_location_system/models/current_user.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LoginService {
  static Future<List?> login() async {
    final loginController = Get.find<LoginController>();

    final response =
        await http.post(Uri.parse("http://10.0.2.2/login/login.php"), body: {
      "username": loginController.user.value.text,
      "password": loginController.pass.value.text,
    });
   
    var datauser = jsonDecode(response.body) as List;
    debugPrint(datauser.toString());

    try {
      if (datauser[0]['username'] == loginController.user.value.text &&
          datauser[0]['password'] == loginController.pass.value.text) {
        User.id = datauser[0]['isci_id'];
        User.firstName = datauser[0]['username'];
        User.status = datauser[0]['status'];
        loginController.successfulLogin();
      }
    } catch (e) {
      loginController.unSuccessfulLogin();
    }

    return datauser;
  }
}
