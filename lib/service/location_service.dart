import 'dart:convert';
import 'package:worker_location_system/models/current_isci.dart';
import 'package:worker_location_system/controllers/location_controller.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class LocationService {
  static Future fetchLocation() async {
    final konumController = Get.find<LocationController>();

    var response =
        await http.post(Uri.parse("http://10.0.2.2/login/konum.php"), body: {
      'worker_id': Isci.workerId,
      'worker_name': Isci.workerName,
      'worker_surname': Isci.workerSurname
    });

    if (response.statusCode == 200) {
      konumController.locationList = await jsonDecode(response.body);
      debugPrint(konumController.locationList.toString());
      konumController.loading = false;

      var sonIndex = konumController.locationList.length - 1;
      var secondIndex = konumController.locationList.length - 2;
      var thirdIndex = konumController.locationList.length - 3;
      try {
        //son konumdan önceki konumu verir
        konumController.sTop.value =
            double.parse(konumController.locationList[secondIndex]['konum_y']);
        konumController.sLeft.value =
            double.parse(konumController.locationList[secondIndex]['konum_x']);
      } catch (e) {
        debugPrint('$e');
        konumController.sTop.value = double.infinity;
        konumController.sLeft.value = double.infinity;
      }

      try {
        //son konumdan iki önceki konumu verir
        konumController.tTop.value =
            double.parse(konumController.locationList[thirdIndex]['konum_y']);
        konumController.tLeft.value =
            double.parse(konumController.locationList[thirdIndex]['konum_x']);
      } catch (e) {
        debugPrint('$e');
        konumController.tTop.value = double.infinity;
        konumController.tLeft.value = double.infinity;
      }
      try {
        //son konumu verir
        konumController.top.value =
            double.parse(konumController.locationList[sonIndex]['konum_y']);
        konumController.left.value =
            double.parse(konumController.locationList[sonIndex]['konum_x']);
      } catch (e) {
        debugPrint('$e');
        konumController.top.value = double.infinity;
        konumController.left.value = double.infinity;
      }

      return konumController.locationList;
    } else {
      throw Exception('Error while fetch api');
    }
  }
}
