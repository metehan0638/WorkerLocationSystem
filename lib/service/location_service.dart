import 'dart:convert';
import 'package:worker_location_system/models/current_isci.dart';
import 'package:worker_location_system/controllers/location_controller.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class LocationService {
  static Future fetchLocation() async {
    final konumController = Get.find<LocationController>();

    
    var response = await http.post(Uri.parse("http://10.0.2.2/login/konum.php"),
        body: {'worker_id': Isci.workerId,'worker_name':Isci.workerName,'worker_surname':Isci.workerSurname});

    if (response.statusCode == 200) {
      konumController.locationList = await jsonDecode(response.body);
      debugPrint(konumController.locationList.toString());
      konumController.loading = false;
      konumController.top.value = double.parse(konumController.locationList.last['konum_y']);
      konumController.left.value = double.parse(konumController.locationList.last['konum_x']);
      return konumController.locationList;
    } else {
      throw Exception('Error while fetch api');
    }
  }
}
