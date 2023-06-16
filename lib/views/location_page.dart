import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:worker_location_system/components/row_widget.dart';
import 'package:worker_location_system/constants/const.dart';
import 'package:worker_location_system/controllers/location_controller.dart';
import 'package:worker_location_system/controllers/theme_controller.dart';
import 'package:worker_location_system/models/current_isci.dart';
import 'package:worker_location_system/service/location_service.dart';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final konumController = Get.find<LocationController>();
  final themeController = Get.find<ThemeController>();

  @override
  void initState() {
    super.initState();

    LocationService.fetchLocation();
    konumController.startTimer();
  }

  @override
  void dispose() {
    super.dispose();

    konumController.myTimer!.cancel();
  }

  PlatformFile? pickedFile;
  UploadTask? uploadTask;
  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    setState(() {
      pickedFile = result.files.first;
      debugPrint(pickedFile!.name);
    });
  }

  Future uploadFile() async {
    final path = 'files/${pickedFile!.name}';
    final file = File(pickedFile!.path!);
    final ref = FirebaseStorage.instance.ref().child(path);
    setState(() {
      uploadTask = ref.putFile(file);
    });

    final snapshot = await uploadTask!.whenComplete(() => null);
    konumController.urlDownload = await snapshot.ref.getDownloadURL();

    setState(() {
      uploadTask = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 5,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back_ios_new_rounded)),
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            'İşçim Nerde ?',
            style: GoogleFonts.mPlus1(
                fontSize: 24, fontWeight: FontWeight.w600, color: Colors.white),
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0, left: 8, top: 5),
              child: Container(
                decoration: BoxDecoration(
                  color: themeController.isDarkMode.value
                      ? HexColor('0B2447')
                      : HexColor('C58940'),
                  borderRadius: BorderRadius.circular(10),
                ),
                width: double.infinity,
                height: 120,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      MyRow(
                          feature: 'İşçi Adı',
                          value: Isci.workerName!.toUpperCase().toString()),
                      MyRow(
                          feature: 'İşçi Soyadı',
                          value: Isci.workerSurname!.toUpperCase().toString()),
                      MyRow(
                          feature: 'Yaşı',
                          value: Isci.workerAge!.toUpperCase().toString()),
                      MyRow(
                          feature: 'Cinsiyeti',
                          value: Isci.workerGender!.toUpperCase().toString()),
                      MyRow(
                          feature: 'İşçi Rolü',
                          value: Isci.workerRole!.toUpperCase().toString()),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Center(
              child: Stack(
                children: [
                  Container(
                      child: konumController.urlDownload != null
                          ? Image.network(
                              width: 300,
                              height: 300,
                              konumController.urlDownload!,
                              fit: BoxFit.fill,
                            )
                          : Image.asset(Constants.mapUrl)),
                  Obx(
                    () => Positioned(
                      top: konumController.top.value,
                      left: konumController.left.value,
                      child: konumController.loading
                          ? const CircularProgressIndicator()
                          : SizedBox(
                              height: 48,
                              width: 48,
                              child: GestureDetector(
                                  onDoubleTap: () {
                                    Get.defaultDialog(
                                      backgroundColor: Colors.green,
                                      title: 'İŞÇİ BİLGİLERİ',
                                      titleStyle: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      content: Column(
                                        children: [
                                          ListTile(
                                            tileColor: Colors.transparent,
                                            trailing: Text('${Isci.workerId}',
                                                style: const TextStyle(
                                                    color: Colors.white)),
                                            leading: const Text(
                                              'İşçi id no',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                          ),
                                          const Divider(
                                            color: Colors.white,
                                          ),
                                          ListTile(
                                            tileColor: Colors.transparent,
                                            trailing: Text(
                                                Isci.workerName!.toUpperCase(),
                                                style: const TextStyle(
                                                    color: Colors.white)),
                                            leading: const Text('İşçi adı',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white)),
                                          ),
                                          const Divider(
                                            color: Colors.white,
                                          ),
                                          ListTile(
                                            tileColor: Colors.transparent,
                                            trailing: Text(
                                                Isci.workerSurname!
                                                    .toUpperCase(),
                                                style: const TextStyle(
                                                    color: Colors.white)),
                                            leading: const Text('İşçi Soyadı',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white)),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  child: Image.asset(
                                      Constants.personLocationGifUrl))),
                    ),
                  ),
                  Obx(() => Positioned(
                      top: konumController.sTop.value,
                      left: konumController.sLeft.value,
                      child: Opacity(
                          opacity: 0.7,
                          child: Image.asset(Constants.personLocationGifUrl)))),
                  Obx(() => Positioned(
                      top: konumController.tTop.value,
                      left: konumController.tLeft.value,
                      child: Opacity(
                          opacity: 0.4,
                          child: Image.asset(Constants.personLocationGifUrl)))),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 35.0, left: 35),
              child: ElevatedButton(
                  onPressed: () {
                    selectFile();
                  },
                  child: Row(
                    children: const [
                      Icon(Icons.image_outlined),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        'Dosyalarımdan Harita Seç',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 35.0, left: 35),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(),
                  onPressed: () {
                    uploadFile();
                  },
                  child: Row(
                    children: const [
                      Icon(Icons.upload),
                      SizedBox(
                        width: 15,
                      ),
                      Text('Fotoğrafı Yükle', style: TextStyle(fontSize: 16)),
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
