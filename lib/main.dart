import 'package:worker_location_system/controllers/exit_controller.dart';
import 'package:worker_location_system/controllers/location_controller.dart';
import 'package:worker_location_system/controllers/login_controller.dart';
import 'package:worker_location_system/controllers/theme_controller.dart';
import 'package:worker_location_system/controllers/worker_list_controller.dart';
import 'package:worker_location_system/routes/app_pages.dart';
import 'package:worker_location_system/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  Get.put(ThemeController());

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ThemeController themeController = Get.find<ThemeController>();
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: themeController.myLightTheme,
      darkTheme: themeController.myDarkTheme,
      initialBinding: BindingsBuilder(() {
        Get.put(ThemeController());
        Get.put(WorkerListController());
        Get.put(LocationController());
        Get.put(ExitController());
        Get.put(LoginController());
      }),
      debugShowCheckedModeBanner: false,
      title: 'Worker Location App',
      initialRoute: Routes.LOGIN_PAGE,
      getPages: Pages.pages,
    );
  }
}
