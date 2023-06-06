import 'dart:io';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:worker_location_system/constants/const.dart';
import 'package:worker_location_system/controllers/location_controller.dart';
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
  File? myImage;
  Future getImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    } else {
      //  final imageTemp = File(image.path);
      final storedImage = await savePickedImage(image.path);
      setState(() {
        myImage = storedImage;
      });
    }
  }

  Future<File> savePickedImage(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File('${directory.path}/$name');
    return File(imagePath).copy(image.path);
  }

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
            const SizedBox(
              height: 100,
            ),
            Center(
              child: Stack(
                children: [
                  Container(
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(color: Colors.grey.shade600, blurRadius: 17)
                      ]),
                      child: myImage != null
                          ? Image.file(
                              semanticLabel: 'map',
                              myImage!,
                              fit: BoxFit.fill,
                              width: 300,
                              height: 300,
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
            ElevatedButton(
                onPressed: () {
                  getImage();
                },
                child: const Text('Haritayı galeriden seç'))
          ],
        ),
      ),
    );
  }
}
