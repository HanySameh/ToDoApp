import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:to_do/db/db_helper.dart';
import 'package:to_do/services/theme_services.dart';
import 'package:to_do/ui/pages/splash_screen.dart';
import 'package:to_do/ui/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // NotifyHelper().initializeNotification();
  await DBHelper.initDb();
  await GetStorage.init();
  if (Get.isDarkMode) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarBrightness: Brightness.dark,
    ));
  } else {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: darkGreyClr,
      statusBarBrightness: Brightness.light,
    ));
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeServices().theme,
      title: 'To Do',
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
