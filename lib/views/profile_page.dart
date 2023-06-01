import 'package:worker_location_system/components/theme_mod_dialog_widget.dart';
import 'package:worker_location_system/constants/const.dart';
import 'package:worker_location_system/controllers/exit_controller.dart';
import 'package:worker_location_system/controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:worker_location_system/models/current_user.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final exitController = Get.find<ExitController>();
  final ThemeController themeController = Get.find();
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: Text(
              'Profil',
              style: GoogleFonts.mPlus1(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            )),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const SizedBox(
                  height: 15,
                ),
                Obx(() => Text(
                    '${User.firstName!.toUpperCase()} Kullanıcısı: ${User.status!.toUpperCase()}',
                    style: themeController.isDarkMode.value == true
                        ? GoogleFonts.mPlus1(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white70)
                        : GoogleFonts.mPlus1(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black))),
                const SizedBox(
                  height: 15,
                ),
                Column(
                  children: [
                    Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(80)),
                      child: Image.asset(Constants.workersUrl),
                    ),
                    const SizedBox(
                      height: 200,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: Obx(() => ListTile(
                            onTap: () {
                              Get.dialog(
                                barrierDismissible: false,
                                const MyThemeDialog(),
                              );
                            },
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  width: 1, color: Colors.white54),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            tileColor: themeController.isDarkMode.value == true
                                ? HexColor('6D5D6E')
                                : HexColor('C69749'),
                            title: Text(
                              'Ayarlar',
                              style: GoogleFonts.mPlus1(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                            subtitle: Text(
                              'Uygulama Ayarları',
                              style: GoogleFonts.mPlus1(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white70),
                            ),
                            leading:
                                const Icon(Icons.settings, color: Colors.black),
                          )),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 4.0, bottom: 8, right: 8, left: 8),
                  child: Obx(() => ListTile(
                        shape: RoundedRectangleBorder(
                          side:
                              const BorderSide(width: 2, color: Colors.white54),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        onTap: () {
                          exitController.ruSure();
                        },
                        tileColor: themeController.isDarkMode.value == true
                            ? HexColor('D21312')
                            : HexColor('ED2B2A'),
                        title: Text(
                          'Çıkış Yap',
                          style: GoogleFonts.mPlus1(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                        subtitle: Text(
                          'Uygulamadan Çıkış Yap',
                          style: GoogleFonts.mPlus1(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.white70),
                        ),
                        leading:
                            const Icon(Icons.exit_to_app, color: Colors.black),
                      )),
                ),
              ],
            ),
          ),
        ));
  }
}
