import 'package:worker_location_system/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ExitController extends GetxController {
  void ruSure() {
    final ButtonStyle acceptStyle =
        ElevatedButton.styleFrom(backgroundColor: Colors.green);
    final ButtonStyle denyStyle =
        ElevatedButton.styleFrom(backgroundColor: Colors.red);
    Get.defaultDialog(
        barrierDismissible: false,
        backgroundColor: Colors.orange,
        titleStyle:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        title: 'Çıkış Yapılıyor',
        content: const Text(
          'Onaylıyor musunuz ?',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          ElevatedButton(
              style: acceptStyle,
              onPressed: () {
                Get.offAllNamed(Routes.LOGIN_PAGE);
              },
              child: Text('Onayla',
                  style: GoogleFonts.mPlus1(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white))),
          ElevatedButton(
              style: denyStyle,
              onPressed: () {
                Get.back();
              },
              child: Text('İptal',
                  style: GoogleFonts.mPlus1(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white)))
        ]);
  }
}
