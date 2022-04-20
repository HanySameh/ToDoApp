import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get.dart';
import 'package:to_do/ui/pages/layout.dart';
import 'package:to_do/ui/theme.dart';
import 'package:to_do/ui/widgets/button.dart';
import 'package:to_do/ui/widgets/input_field.dart';

import '../../services/theme_services.dart';
import '../size_config.dart';

String username = 'User';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var nameController = TextEditingController();
  bool login = false;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.centerLeft,
              children: [
                ClipPath(
                  clipper: WaveClipperTwo(),
                  child: Container(
                    height: 300.0,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          primaryClr,
                          Colors.blue[500]!,
                        ],
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 25.0),
                  child: Text(
                    'LOGIN',
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 30.0,
                left: 20.0,
                right: 20.0,
                bottom: 10.0,
              ),
              child: Text(
                'enter your name to login and create your first task',
                style: Theme.of(context)
                    .textTheme
                    .caption!
                    .copyWith(fontSize: 15.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: InputField(
                controller: nameController,
                title: 'Name',
                hint: 'Enter your frist name here...',
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            CustomButton(
              lable: 'Next',
              onTap: () {
                if (nameController.text != '') {
                  setState(() {
                    username = nameController.text;
                  });
                  LoginScreenServices().switchScreen(login);
                  print(username);
                } else {
                  Get.snackbar(
                    'Name Required',
                    'Please enter your name',
                    colorText: Colors.red,
                    backgroundColor: Colors.white,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
