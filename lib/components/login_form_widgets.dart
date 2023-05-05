import 'package:worker_location_system/components/login_button_widget.dart';
import 'package:worker_location_system/components/login_welcome_widgets.dart';
import 'package:worker_location_system/components/password_textfield_widget.dart';
import 'package:worker_location_system/components/username_textfield_widget.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          children: const [
            MyLoginWelcome(),
            SizedBox(
              height: 64,
            ),
            MyUsernameTextField(),
            SizedBox(
              height: 12,
            ),
            MyPasswordTextField(),
            SizedBox(
              height: 44,
            ),
            MyLoginButton(),
          ],
        ),
      ),
    );
  }
}
