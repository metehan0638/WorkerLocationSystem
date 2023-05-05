import 'dart:convert';
import 'package:worker_location_system/models/current_isci.dart';
import 'package:worker_location_system/controllers/location_controller.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class LocationService {
  static Future fetchLocation() async {
    final konumController = Get.find<LocationController>();

    late List locationList;
    var response = await http.post(Uri.parse("http://10.0.2.2/login/konum.php"),
        body: {'isci_id': Isci.isciId});

    if (response.statusCode == 200) {
      locationList = await jsonDecode(response.body);
      debugPrint(locationList.toString());
      konumController.loading = false;
      konumController.top.value = double.parse(locationList.last['konum_y']);
      konumController.left.value = double.parse(locationList.last['konum_x']);
      return locationList;
    } else {
      throw Exception('Error while fetch api');
    }
  }
}
