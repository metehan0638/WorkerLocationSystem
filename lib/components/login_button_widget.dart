import 'package:worker_location_system/service/login_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class MyLoginButton extends StatelessWidget {
  const MyLoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          side: BorderSide(width: 1, color: HexColor('#f0ffff')),
          elevation: 3,
          backgroundColor: HexColor('#43cb7b'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        onPressed: () {
          LoginService.login();
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 12, bottom: 12),
          child: Text('Giriş',
              style: GoogleFonts.mPlus1(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: HexColor('#f0ffff'))),
        ),
      ),
    );
  }
}
