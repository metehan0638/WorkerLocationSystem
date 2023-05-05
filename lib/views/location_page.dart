import 'package:worker_location_system/constants/const.dart';
import 'package:worker_location_system/controllers/location_controller.dart';
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
                      child: Image.asset(Constants.mapUrl)),
                  Obx(
                    () => Positioned(
                      top: konumController.top.value,
                      left: konumController.left.value,
                      child: konumController.loading
                          ? const CircularProgressIndicator()
                          : SizedBox(
                              height: 48,
                              width: 48,
                              child:
                                  Image.asset(Constants.personLocationGifUrl)),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
