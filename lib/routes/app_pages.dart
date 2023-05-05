import 'package:worker_location_system/components/bottom_navbar_widget.dart';
import 'package:worker_location_system/views/login_page.dart';

import 'package:worker_location_system/views/worker_list_page.dart';
import 'package:get/get.dart';
import 'package:worker_location_system/routes/app_routes.dart';

abstract class Pages {
  static List<GetPage> pages = [
    GetPage(name: Routes.HOME_PAGE, page: () => const MyBottomNav()),
    GetPage(name: Routes.LOGIN_PAGE, page: () => const LoginPage()),
    GetPage(name: Routes.WORKER_LIST_PAGE, page: () => const WorkerListPage()),
    
  ];
}
