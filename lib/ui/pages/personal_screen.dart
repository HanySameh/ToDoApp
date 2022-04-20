import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:to_do/services/notification_services.dart';
import 'package:to_do/ui/pages/update_task_screen.dart';
import 'package:to_do/ui/size_config.dart';
import 'package:to_do/ui/theme.dart';
import 'package:to_do/ui/widgets/task_tile.dart';

import '../../controllers/task_controller.dart';
import '../../models/task.dart';

class PersonalTasks extends StatefulWidget {
  const PersonalTasks({Key? key}) : super(key: key);

  @override
  State<PersonalTasks> createState() => _PersonalTasksState();
}

final TaskController taskController = Get.put(TaskController());
late NotifyHelper notifyHelper;

class _PersonalTasksState extends State<PersonalTasks> {
  @override
  void initState() {
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermissions();
    taskController.getTasks();
  }

  DateTime selecedTime = DateTime.now();
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0.0,
        title: Text(
          'Personal',
          style: headingStyle.copyWith(
            color: primaryClr,
          ),
        ),
      ),
      body: Column(
        children: [
          // Container(
          //   margin: const EdgeInsets.only(
          //     left: 20.0,
          //     right: 10.0,
          //     top: 10.0,
          //   ),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Text(
          //             DateFormat.yMMMd().format(DateTime.now()),
          //             style: subHeadingStyle,
          //           ),
          //           Text(
          //             'Today',
          //             style: headingStyle,
          //           ),
          //         ],
          //       ),
          //       // CustomButton(
          //       //   lable: '+ add task',
          //       //   onTap: () async {
          //       //     await Get.to(const AddTaskPage());
          //       //     taskController.getTasks();
          //       //   },
          //       // ),
          //       Padding(
          //         padding: const EdgeInsets.only(right: 15.0),
          //         child: IconButton(
          //           onPressed: () {
          //             Get.defaultDialog(
          //               title: 'Warning',
          //               middleText:
          //                   'This button will delete all tasks,if you agree press OK.',
          //               titleStyle: const TextStyle(color: Colors.red),
          //               textCancel: 'Cancel',
          //               textConfirm: 'OK',
          //               onConfirm: () {
          //                 notifyHelper.cancelAllNotification();
          //                 taskController.deleteAllTasks();
          //                 Get.back();
          //               },
          //               cancelTextColor: Colors.grey,
          //               confirmTextColor: Colors.white,
          //               buttonColor: primaryClr,
          //             );
          //           },
          //           icon: Icon(
          //             Icons.delete,
          //             size: 30.0,
          //             color: Get.isDarkMode ? Colors.white : darkGreyClr,
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // Container(
          //   margin: const EdgeInsets.only(top: 6.0, left: 20.0),
          //   child: CalendarTimeline(
          //     initialDate: selecedTime,
          //     firstDate: DateTime(2021, 1, 15),
          //     lastDate: DateTime(2030, 11, 20),
          //     onDateSelected: (date) {
          //       setState(() {
          //         selecedTime = date!;
          //       });
          //     },
          //     leftMargin: 20,
          //     monthColor: Colors.grey,
          //     dayColor: Colors.blueAccent[100],
          //     activeDayColor: Colors.white,
          //     activeBackgroundDayColor: primaryClr,
          //     dotsColor: const Color(0xFF333A47),
          //     selectableDayPredicate: (date) => date.day != 23,
          //     locale: 'en_ISO',
          //   ),
          // ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  'Personal Tasks',
                  style: headingStyle,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20.0,
          ),
          Expanded(
            child: Obx(() {
              if (taskController.personalTaskList!.isEmpty) {
                return noTasks(context);
              } else {
                return RefreshIndicator(
                  onRefresh: () async {
                    await taskController.getTasks();
                  },
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection:
                        SizeConfig.orientation == Orientation.landscape
                            ? Axis.horizontal
                            : Axis.vertical,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      var task = taskController.personalTaskList![index];

                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 1375),
                        child: SlideAnimation(
                          horizontalOffset: 300,
                          child: FadeInAnimation(
                            child: GestureDetector(
                              onTap: (() {
                                showBottomSheet(
                                  context,
                                  task,
                                );
                              }),
                              child: TaskTile(task),
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: taskController.personalTaskList!.length,
                  ),
                );
              }
            }),
          ),
        ],
      ),
    );
  }

  noTasks(context) => Center(
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(
                milliseconds: 2000,
              ),
              child: Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                direction: SizeConfig.orientation == Orientation.landscape
                    ? Axis.horizontal
                    : Axis.vertical,
                children: [
                  SizeConfig.orientation == Orientation.landscape
                      ? const SizedBox(
                          height: 6.0,
                        )
                      : const SizedBox(
                          height: 220.0,
                        ),
                  SvgPicture.asset(
                    'images/task.svg',
                    color: primaryClr.withOpacity(0.5),
                    semanticsLabel: 'Task',
                    height: 100.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30.0,
                      vertical: 10.0,
                    ),
                    child: Text(
                      'you don\'t have eny tasks completed yet!,\n finish some tasks',
                      style: subTitleStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizeConfig.orientation == Orientation.landscape
                      ? const SizedBox(
                          height: 120.0,
                        )
                      : const SizedBox(
                          height: 180.0,
                        ),
                ],
              ),
            )
          ],
        ),
      );
  showBottomSheet(context, Task task) {
    Get.bottomSheet(
      SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 4.0),
          width: SizeConfig.screenWidth,
          height: SizeConfig.orientation == Orientation.landscape
              ? task.isCompleted == 1
                  ? SizeConfig.screenHeight * 0.6
                  : SizeConfig.screenHeight * 0.8
              : task.isCompleted == 1
                  ? SizeConfig.screenHeight * 0.30
                  : SizeConfig.screenHeight * 0.39,
          color: Get.isDarkMode ? darkHeaderClr : Colors.white,
          child: Expanded(
            child: Column(
              children: [
                Flexible(
                  child: Container(
                    height: 6.0,
                    width: 120.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color:
                          Get.isDarkMode ? Colors.grey[600] : Colors.grey[300],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                if (task.isCompleted == 0)
                  buildBottomSheet(
                    label: 'Task Completed',
                    onTap: () {
                      notifyHelper.cancleNotification(task);
                      taskController.taskCompleted(task.id!);
                      Get.back();
                    },
                    color: primaryClr,
                  ),
                buildBottomSheet(
                  label: 'Edit Task',
                  onTap: () {
                    Get.back();
                    Get.to(UpdateTaskScreen(
                      task: task,
                    ));
                  },
                  color: primaryClr,
                ),
                buildBottomSheet(
                  label: 'Delete Task',
                  onTap: () {
                    notifyHelper.cancleNotification(task);
                    taskController.deleteTasks(task);
                    Get.back();
                  },
                  color: Colors.red,
                ),
                Divider(
                  color: Get.isDarkMode ? Colors.grey : darkGreyClr,
                ),
                buildBottomSheet(
                  label: 'Cancle',
                  onTap: () {
                    Get.back();
                  },
                  color: primaryClr,
                ),
                const SizedBox(
                  height: 10.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildBottomSheet({
    required String label,
    required Function() onTap,
    required Color color,
    bool isClose = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        height: 55.0,
        width: SizeConfig.screenWidth * 0.9,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2.0,
            color: isClose
                ? Get.isDarkMode
                    ? Colors.grey[600]!
                    : Colors.grey[300]!
                : color,
          ),
          borderRadius: BorderRadius.circular(20.0),
          color: isClose ? Colors.transparent : color,
        ),
        child: Center(
          child: Text(
            label,
            style: isClose
                ? titleStyle
                : titleStyle.copyWith(
                    color: Colors.white,
                  ),
          ),
        ),
      ),
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