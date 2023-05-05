import 'package:worker_location_system/components/login_form_widgets.dart';
import 'package:worker_location_system/constants/const.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    const AssetImage(Constants.backgroundUrl);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Constants.backgroundUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const LoginForm(),
          ],
        ),
      ),
    );
  }
}
