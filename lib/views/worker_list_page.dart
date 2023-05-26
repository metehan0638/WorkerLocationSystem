import 'package:worker_location_system/constants/const.dart';
import 'package:worker_location_system/controllers/theme_controller.dart';
import 'package:worker_location_system/models/current_isci.dart';
import 'package:worker_location_system/controllers/worker_list_controller.dart';
import 'package:worker_location_system/routes/app_routes.dart';
import 'package:worker_location_system/service/worker_list_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class WorkerListPage extends StatefulWidget {
  const WorkerListPage({super.key});

  @override
  State<WorkerListPage> createState() => _WorkerListPageState();
}

class _WorkerListPageState extends State<WorkerListPage> {
  @override
  void initState() {
    super.initState();

    setState(() {
      WorkerListService.getWorkerList();
    });
  }

  late final bool isBuilding;
  late final GetMaterialController controller;
  @override
  Widget build(BuildContext context) {
    final workerListController = Get.find<WorkerListController>();
    final ThemeController themeController = Get.find();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          WorkerListService.getWorkerList();
        },
        splashColor: Colors.lightGreenAccent,
        highlightElevation: 22,
        foregroundColor: Colors.white,
        elevation: 24,
        child: const Icon(
          Icons.refresh_sharp,
          size: 33,
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            'İşçi Listesi',
            style: GoogleFonts.mPlus1(
                fontSize: 24, fontWeight: FontWeight.w600, color: Colors.white),
          )),
      body: Obx(
        () => workerListController.loading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: workerListController.workerList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Isci.workerId =
                          workerListController.workerList[index]['worker_id'];
                      Isci.workerName =
                          workerListController.workerList[index]['worker_name'];
                      Isci.workerSurname = workerListController
                          .workerList[index]['worker_surname'];
                      Get.toNamed(Routes.HOME_PAGE);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 2.0, horizontal: 4),
                      child: Obx(() => ListTile(
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  width: 2, color: Colors.white),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            trailing: themeController.isDarkMode.value == true
                                ? const Icon(
                                    Icons.keyboard_arrow_right,
                                    color: Colors.white,
                                    size: 36,
                                  )
                                : const Icon(
                                    Icons.keyboard_arrow_right,
                                    color: Colors.black87,
                                    size: 36,
                                  ),
                            leading: CircleAvatar(
                              radius: 35,
                              child: Image.asset(Constants.workerUrl),
                            ),
                            title: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 25.0),
                              child: themeController.isDarkMode.value == true
                                  ? Text(
                                      ' ${workerListController.workerList[index]['worker_id']}.${workerListController.workerList[index]['worker_name']} ${workerListController.workerList[index]['worker_surname']}',
                                      style: GoogleFonts.mPlus1(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
                                    )
                                  : Text(
                                      ' ${workerListController.workerList[index]['worker_id']}.${workerListController.workerList[index]['worker_name']} ${workerListController.workerList[index]['worker_surname']}',
                                      style: GoogleFonts.mPlus1(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black),
                                    ),
                            ),
                          )),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
