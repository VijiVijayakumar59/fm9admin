// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fmadmin/core/constants/constants.dart';
import 'package:fmadmin/models/services/auth_sevices/admin_auth.dart';
import 'package:fmadmin/view/home/screens/home.dart';
import 'package:fmadmin/view/login/widgets/elevated_button.dart';
import 'package:fmadmin/view/login/widgets/textform_widget.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  final AdminAuthentication authService = AdminAuthentication();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 244, 204, 201),
        title: const Text(
          "FM9",
        ),
      ),
      body: Form(
        key: loginKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Admin Login",
              style: TextStyle(
                color: Colors.red,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const KHeight(size: 0.04),
            TextFormWidget(
              prefixIcon: Icons.person_2_outlined,
              hintText: "Username",
              textController: emailController,
            ),
            const KHeight(size: 0.02),
            TextFormWidget(
              prefixIcon: Icons.lock_outline_rounded,
              hintText: "password",
              textController: passwordController,
            ),
            const KHeight(size: 0.02),
            ElevatedButtonWidget(
              text: "Login",
              bgColor: Colors.red,
              onPress: () async {
                if (loginKey.currentState!.validate()) {
                  log('Validation success');

                  Map<String, dynamic> loginResult = await authService.login(
                    emailController.text,
                    passwordController.text,
                  );

                  log('Login Result: $loginResult');

                  if (loginResult.containsKey('success')) {
                    if (loginResult['success'] == true) {
                      log('Login successful');

                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                              Text('Login failed: ${loginResult['error']}'),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    }
                  }
                }
              },
            )
          ],
        ),
      ),
    ));
  }
}
