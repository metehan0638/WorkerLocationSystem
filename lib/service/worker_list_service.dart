import 'dart:convert';
import 'package:worker_location_system/controllers/worker_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class WorkerListService {
  static Future<List> getWorkerList() async {
    final workerListController = Get.find<WorkerListController>();

    var response =
        await http.get(Uri.parse("http://10.0.2.2/login/isci_id.php"));

    debugPrint(response.statusCode.toString());
    if (response.statusCode == 200) {
      workerListController.workerList.value = jsonDecode(response.body);
      workerListController.loading.value = false;
      
      return workerListController.workerList;
    } else {
      throw Exception('Error while fetch api');
    }
  }
}
