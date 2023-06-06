import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class ThemeController extends GetxController {
  RxBool isDarkMode = false.obs;
  RxString lightMode = 'Aydınlık Mod'.obs;
  RxString darkMode = 'Karanlık Mod'.obs;
  ThemeData myLightTheme = ThemeData(
      bottomNavigationBarTheme:
          BottomNavigationBarThemeData(backgroundColor: HexColor('C58940')),
      listTileTheme: ListTileThemeData(tileColor: HexColor('E5BA73')),
      scaffoldBackgroundColor: HexColor('FAEAB1'),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.green.withOpacity(0.95)),
      appBarTheme: AppBarTheme(color: HexColor('C58940')));

  ThemeData myDarkTheme = ThemeData(
      bottomNavigationBarTheme:
          BottomNavigationBarThemeData(backgroundColor: HexColor('0B2447')),
      dialogBackgroundColor: HexColor('19376D'),
      listTileTheme: ListTileThemeData(tileColor: HexColor('576CBC')),
      scaffoldBackgroundColor: HexColor('19376D'),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: HexColor('0B2447').withOpacity(0.95)),
      appBarTheme: AppBarTheme(color: HexColor('0B2447')));
}
