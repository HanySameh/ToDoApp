import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:to_do/services/notification_services.dart';
import 'package:to_do/services/theme_services.dart';
import 'package:to_do/ui/pages/add_task_page.dart';
import 'package:to_do/ui/pages/completed_task_screen.dart';
import 'package:to_do/ui/pages/fitness_screen.dart';
import 'package:to_do/ui/pages/learning_screen.dart';
import 'package:to_do/ui/pages/personal_screen.dart';
import 'package:to_do/ui/pages/to_do_task_screen.dart';
import 'package:to_do/ui/pages/today_tasks.dart';
import 'package:to_do/ui/pages/work_screen.dart';
import 'package:to_do/ui/size_config.dart';
import 'package:to_do/ui/theme.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../controllers/task_controller.dart';

class ToDoLayout extends StatefulWidget {
  const ToDoLayout({Key? key}) : super(key: key);

  @override
  State<ToDoLayout> createState() => _ToDoLayoutState();
}

final TaskController taskController = Get.put(TaskController());
late NotifyHelper notifyHelper;

class _ToDoLayoutState extends State<ToDoLayout> {
  @override
  void initState() {
    super.initState();
    // notifyHelper = NotifyHelper();
    // notifyHelper.initializeNotification();
    // notifyHelper.requestIOSPermissions();
    taskController.getTasks();
  }

  DateTime selecedTime = DateTime.now();
  int currentIndex = 0;
  List<Widget> screens = [
    const ToDoTasks(),
    const TodayTasks(),
    const CompletedTasks(),
  ];
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0.0,
        actions: [
          // IconButton(
          //   onPressed: () {
          //     Get.defaultDialog(
          //       title: 'Warning',
          //       middleText:
          //           'This button will delete all tasks,if you agree press OK.',
          //       titleStyle: const TextStyle(color: Colors.red),
          //       textCancel: 'Cancel',
          //       textConfirm: 'OK',
          //       onConfirm: () {
          //         notifyHelper.cancelAllNotification();
          //         taskController.deleteAllTasks();
          //         Get.back();
          //       },
          //       cancelTextColor: Colors.grey,
          //       confirmTextColor: Colors.white,
          //       buttonColor: primaryClr,
          //     );
          //   },
          //   icon: Icon(
          //     Icons.delete,
          //     color: Get.isDarkMode ? Colors.white : darkGreyClr,
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: IconButton(
              padding: const EdgeInsets.only(
                left: 15.0,
              ),
              onPressed: () {
                ThemeServices().switchThemeMode();
                if (Get.isDarkMode) {
                  SystemChrome.setSystemUIOverlayStyle(
                      const SystemUiOverlayStyle(
                    statusBarColor: Colors.white,
                    statusBarBrightness: Brightness.dark,
                  ));
                } else {
                  SystemChrome.setSystemUIOverlayStyle(
                      const SystemUiOverlayStyle(
                    statusBarColor: darkGreyClr,
                    statusBarBrightness: Brightness.light,
                  ));
                }
              },
              icon: Icon(
                Get.isDarkMode
                    ? Icons.wb_sunny_outlined
                    : Icons.nightlight_round_outlined,
                color: Get.isDarkMode ? Colors.white : darkGreyClr,
              ),
            ),
          ),
          const SizedBox(
            width: 20.0,
          ),
          const CircleAvatar(
            radius: 18.0,
            backgroundImage: AssetImage(
              'images/op_logo.jpg',
            ),
          ),
          const SizedBox(
            width: 20.0,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Get.to(const AddTaskPage());
          taskController.getTasks();
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: primaryClr,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        backgroundColor: Theme.of(context).backgroundColor,
        selectedItemColor: Get.isDarkMode ? Colors.white : darkGreyClr,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        elevation: 0.0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.calendar_today,
            ),
            label: 'Calender',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.today_rounded,
            ),
            label: 'Today',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.done_outline,
            ),
            label: 'Completed',
          ),
        ],
        onTap: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
      drawer: Drawer(
        backgroundColor: Theme.of(context).backgroundColor,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 40.0,
                  backgroundImage: AssetImage(
                    'images/op_logo.jpg',
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  'User Name',
                  style: headingStyle,
                ),
                const SizedBox(
                  height: 15.0,
                ),
                const Divider(
                  height: 5.0,
                  color: Colors.grey,
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Text(
                  'Categoty',
                  style: subHeadingStyle,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                InkWell(
                  onTap: () {
                    Get.back();
                    Get.to(const LearningTasks());
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.science,
                          color: primaryClr,
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          'Learning',
                          style: subTitleStyle,
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.back();
                    Get.to(const PersonalTasks());
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.person,
                          color: primaryClr,
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          'Personal',
                          style: subTitleStyle,
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.back();
                    Get.to(const WorkTasks());
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.work,
                          color: primaryClr,
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          'Work',
                          style: subTitleStyle,
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.back();
                    Get.to(const FitnessTasks());
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.fitness_center,
                          color: primaryClr,
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          'Fitness',
                          style: subTitleStyle,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                const Divider(
                  height: 5.0,
                  color: Colors.grey,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () async {
                          const String url =
                              'https://twitter.com/hanysameh11?t=_-XBJoiTwM8GroEVhG0tYg&s=09';
                          if (await canLaunch(url)) {
                            await launch(
                              url,
                              forceSafariVC: true,
                              forceWebView: true,
                              enableJavaScript: true,
                            );
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                        icon: const Icon(
                          FontAwesomeIcons.twitter,
                          size: 30.0,
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      IconButton(
                        onPressed: () async {
                          const String url =
                              'https://www.facebook.com/hany.sameh23';
                          if (await canLaunch(url)) {
                            await launch(
                              url,
                              forceSafariVC: true,
                              forceWebView: true,
                              enableJavaScript: true,
                            );
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                        icon: const Icon(
                          FontAwesomeIcons.facebook,
                          size: 30.0,
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      IconButton(
                        onPressed: () async {
                          const String url =
                              'https://instagram.com/hany_sameh_?igshid=YmMyMTA2M2Y=';
                          if (await canLaunch(url)) {
                            await launch(
                              url,
                              forceSafariVC: true,
                              forceWebView: true,
                              enableJavaScript: true,
                            );
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                        icon: const Icon(
                          FontAwesomeIcons.instagram,
                          size: 30.0,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Center(
                  child: Text(
                    'From\n One Piece',
                    textAlign: TextAlign.center,
                    style: subTitleStyle.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: screens[currentIndex],
    );
  }
}



//  DatePicker(
//               DateTime.now(),
//               height: 100.0,
//               width: 70.0,
//               initialSelectedDate: DateTime.now(),
//               selectedTextColor: Colors.white,
//               selectionColor: primaryClr,
//               onDateChange: (date) {
//                 setState(() {
//                   selecedTime = date;
//                 });
//               },
//               dateTextStyle: GoogleFonts.lato(
//                 textStyle: const TextStyle(
//                   color: Colors.grey,
//                   fontSize: 20.0,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               dayTextStyle: GoogleFonts.lato(
//                 textStyle: const TextStyle(
//                   color: Colors.grey,
//                   fontSize: 16.0,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               monthTextStyle: GoogleFonts.lato(
//                 textStyle: const TextStyle(
//                   color: Colors.grey,
//                   fontSize: 12.0,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),