import 'package:worker_location_system/controllers/theme_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class MyThemeDialog extends StatefulWidget {
  const MyThemeDialog({super.key});

  @override
  State<MyThemeDialog> createState() => _MyThemeDialogState();
}

class _MyThemeDialogState extends State<MyThemeDialog> {
  final ThemeController themeController = Get.find();


  @override
  Widget build(BuildContext context) {
    return Obx(() => AlertDialog(
        elevation: 2,
        shadowColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        actions: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
              onPressed: () => Get.back(),
              child: const Text(
                'Tamam',
                style: TextStyle(color: Colors.blue),
              )),
        ],
        backgroundColor: themeController.isDarkMode.value == true
            ? HexColor('0B2447')
            : HexColor('C58940'),
        title: themeController.isDarkMode.value == true
            ? const Center(
                child: Text(
                  'Ayarlar',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              )
            : const Center(
                child: Text(
                  'Ayarlar',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            themeController.isDarkMode.value == true
                ? const Icon(
                    Icons.dark_mode,
                    size: 26,
                    color: Colors.white,
                  )
                : const Icon(
                    size: 26,
                    Icons.light_mode,
                    color: Colors.yellow,
                  ),
            themeController.isDarkMode.value == true
                ? Obx(() => Text(themeController.darkMode.value,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 18)))
                : Obx(() => Text(
                      themeController.lightMode.value,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 18),
                    )),
            Obx(() => Switch(
                  inactiveThumbColor: Colors.orange.shade500,
                  inactiveTrackColor: Colors.yellow.shade100,
                  hoverColor: Colors.red,
                  activeColor: Colors.deepPurple,
                  activeTrackColor: Colors.deepPurple.shade300,
                  value: themeController.isDarkMode.value,
                  onChanged: (value) {
                    themeController.isDarkMode.value = value;
                 
                  
                    themeController.isDarkMode.value
                        ? ThemeMode.dark
                        : ThemeMode.light;
                    Get.changeThemeMode(themeController.isDarkMode.value
                        ? ThemeMode.dark
                        : ThemeMode.light);
                  },
                ))
          ],
        )));
  }
}
