import 'package:worker_location_system/constants/const.dart';
import 'package:worker_location_system/controllers/location_controller.dart';
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
  final workerListController = Get.find<WorkerListController>();
  final ThemeController themeController = Get.find();
  final konumController = Get.find<LocationController>();
  List foundWorkers = [];
  @override
  void initState() {
    super.initState();

    setState(() {
      WorkerListService.getWorkerList();
      foundWorkers = workerListController.workerList;
    });
  }

  void workerFilter(String enteredKeyword) {
    List results = [];
    if (enteredKeyword.isEmpty) {
      results = workerListController.workerList;
    } else {
      results = workerListController.workerList
          .where((worker) => worker["worker_name"]
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      foundWorkers = results;
    });
  }

  @override
  void dispose() {
    super.dispose();
    workerListController.searchFieldController;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: 65,
        height: 60,
        child: FloatingActionButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
          onPressed: () {
            WorkerListService.getWorkerList();
            debugPrint(foundWorkers.toString());
          },
          splashColor: Colors.lightGreenAccent,
          highlightElevation: 22,
          foregroundColor: Colors.white,
          elevation: 24,
          child: const Icon(size: 24, Icons.refresh),
        ),
      ),
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
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Obx(
                      () => TextField(
                        onEditingComplete: () =>
                            workerListController.focusNode.unfocus(),
                        onSubmitted: (value) =>
                            workerListController.focusNode.unfocus(),
                        onTapOutside: (event) =>
                            workerListController.focusNode.unfocus(),
                        style: TextStyle(
                            color: themeController.isDarkMode.value == true
                                ? Colors.white
                                : Colors.black),
                        onChanged: (value) => workerFilter(value),
                        focusNode: workerListController.focusNode,
                        textInputAction: TextInputAction.none,
                        controller:
                            workerListController.searchFieldController.value,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    width: 2,
                                    color:
                                        themeController.isDarkMode.value == true
                                            ? Colors.white
                                            : Colors.blueGrey)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    width: 2,
                                    color:
                                        themeController.isDarkMode.value == true
                                            ? Colors.green
                                            : Colors.blue)),
                            hintText: 'Bir işçi arayın',
                            hintStyle: themeController.isDarkMode.value == true
                                ? TextStyle(color: Colors.grey[300])
                                : const TextStyle(color: Colors.grey),
                            prefixIcon: Icon(Icons.person_search,
                                color: themeController.isDarkMode.value == true
                                    ? Colors.white
                                    : Colors.blue),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 16.0)),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      controller: workerListController.scrollController,
                      itemCount: foundWorkers.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            workerListController.focusNode.unfocus();
                            Isci.workerId = foundWorkers[index]['worker_id'];
                            Isci.workerName =
                                foundWorkers[index]['worker_name'];
                            Isci.workerSurname =
                                foundWorkers[index]['worker_surname'];

                            Get.toNamed(Routes.HOME_PAGE);
                          },
                          child: Obx(
                            () => Card(
                              key: ValueKey(foundWorkers[index]['worker_id']),
                              child: ListTile(
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                      width: 2, color: Colors.white),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                trailing:
                                    themeController.isDarkMode.value == true
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
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 25.0),
                                  child:
                                      themeController.isDarkMode.value == true
                                          ? Text(
                                              ' ${foundWorkers[index]['worker_id']}.${foundWorkers[index]['worker_name']} ${foundWorkers[index]['worker_surname']}',
                                              style: GoogleFonts.mPlus1(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white),
                                            )
                                          : Text(
                                              ' ${foundWorkers[index]['worker_id']}.${foundWorkers[index]['worker_name']} ${foundWorkers[index]['worker_surname']}',
                                              style: GoogleFonts.mPlus1(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black),
                                            ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
