import 'package:worker_location_system/constants/const.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyLoginWelcome extends StatelessWidget {
  const MyLoginWelcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        Text(
          Constants.loginText,
          style: GoogleFonts.mPlus1(
              wordSpacing: 1,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
        const SizedBox(
          height: 20,
        ),
        const SizedBox(
          height: 10,
        ),
        Text('İşçi Konum Takip Sistemi',
            style: GoogleFonts.mPlus1(
                wordSpacing: 12,
                fontSize: 23,
                fontWeight:FontWeight.bold,
                color: Colors.black)),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 150,
          width: double.infinity,
          child: Image.asset(Constants.workersUrl),
        ),
        Container(
          height: 5,
          width: 170,
          decoration: const BoxDecoration(
            color: Colors.transparent,
            boxShadow: [
              BoxShadow(
                  color: Colors.black,
                  blurRadius: 15.0,
                  offset: Offset(0.0, 0.75))
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    ));
  }
}
