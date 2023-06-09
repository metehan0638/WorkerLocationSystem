import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Constants {
  static const String loginText = 'L o g i n';
  static const String workersUrl = "lib/assets/workers.png";
  static const String workerUrl = "lib/assets/worker.png";
  static const String successfulLoginUrl = "lib/assets/successful_login.gif";
  static const String backgroundUrl = "lib/assets/bg_workers.jpeg";
  static const String personLocationGifUrl = "lib/assets/person_location.gif";
  static const String mapUrl = "lib/assets/mykorki.png";
  static TextStyle googleFont =
      GoogleFonts.mPlus1(fontWeight: FontWeight.w600, color: Colors.black);
  static TextStyle profileUserFontStyle =
      GoogleFonts.mPlus1(fontWeight: FontWeight.w600, color: Colors.black);

  static TextStyle googleTextFeatureStyle = GoogleFonts.mPlus1(
      fontWeight: FontWeight.w600, color: Colors.white, fontSize: 14);
  static TextStyle googleTextValueStyle = GoogleFonts.mPlus1(
      fontWeight: FontWeight.w500, color: Colors.white, fontSize: 13);
}
