import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WorkerListController extends GetxController {
  RxList workerList = [].obs;
  RxBool loading = true.obs;
  Rx<TextEditingController> searchFieldController =TextEditingController().obs;
  final FocusNode focusNode = FocusNode();
  ScrollController scrollController = ScrollController();
}
