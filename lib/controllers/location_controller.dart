import 'dart:async';
import 'package:worker_location_system/service/location_service.dart';
import 'package:get/get.dart';

class LocationController extends GetxController {
  RxDouble top = 0.0.obs;
  RxDouble left = 0.0.obs;
  bool loading = true;
late List locationList;
  Timer? myTimer;

  void startTimer() {
    myTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      LocationService.fetchLocation();
    });
  }
}
