import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:to_do/ui/pages/layout.dart';
import 'package:to_do/ui/pages/login_screen.dart';
import 'package:to_do/ui/pages/on_boarding_screen.dart';

class ThemeServices {
  final GetStorage box = GetStorage();
  final key = 'isDarkMode';
  saveThemetoBox(bool isDarkMode) {
    box.write(key, isDarkMode);
  }

  bool loadThemeFromBox() {
    return box.read(key) ?? false;
  }

  ThemeMode get theme => loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light;

  void switchThemeMode() {
    Get.changeThemeMode(loadThemeFromBox() ? ThemeMode.light : ThemeMode.dark);
    saveThemetoBox(!loadThemeFromBox());
  }
}

class BoardingServices {
  final GetStorage box = GetStorage();
  final boardingKey = 'onBoarding';
  saveScreentoBox(bool onBoarding) {
    box.write(boardingKey, onBoarding);
  }

  bool loadScreenFromBox() {
    return box.read(boardingKey) ?? false;
  }

  Widget get screen => loadScreenFromBox()
      ? LoginScreenServices().screen
      : const OnBoardingScreen();

  void switchScreen(bool onBoarding) {
    onBoarding = true;
    saveScreentoBox(!loadScreenFromBox());
    Get.off(const LoginScreen());
  }
}

class LoginScreenServices {
  final GetStorage box = GetStorage();
  final loginKey = 'login';
  saveLoginScreentoBox(bool login) {
    box.write(loginKey, login);
  }

  bool loadLoginScreenFromBox() {
    return box.read(loginKey) ?? false;
  }

  Widget get screen =>
      loadLoginScreenFromBox() ? const ToDoLayout() : const LoginScreen();

  void switchScreen(bool login) {
    login = true;
    saveLoginScreentoBox(!loadLoginScreenFromBox());
    Get.off(const ToDoLayout());
  }
}
