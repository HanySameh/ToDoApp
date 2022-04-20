import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:to_do/controllers/task_controller.dart';
import 'package:to_do/models/task.dart';
import 'package:to_do/ui/size_config.dart';
import 'package:to_do/ui/theme.dart';
import 'package:to_do/ui/widgets/button.dart';
import 'package:to_do/ui/widgets/input_field.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TaskController taskController = Get.put(TaskController());
  final TextEditingController titleController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  DateTime selectDate = DateTime.now();
  String startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  String endTime = DateFormat('hh:mm a')
      .format(DateTime.now().add(const Duration(minutes: 15)))
      .toString();

  int selectRemind = 5;
  List<int> remindList = [5, 10, 15, 20];
  String selectRepeat = 'none';
  List<String> repeatList = ['none', 'Daily', 'Weekly', 'Monthly'];
  int selectColor = 0;
  String selectCategory = 'none';
  List<String> categoryList = [
    'none',
    'learning',
    'personal',
    'work',
    'fitness'
  ];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0.0,
        leading: IconButton(
          padding: const EdgeInsets.only(
            left: 15.0,
          ),
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: primaryClr,
          ),
        ),
        // title: const Text(
        //   'New Task',
        //   style: TextStyle(
        //     color: primaryClr,
        //   ),
        // ),
        // titleSpacing: 0.0,
        actions: const [
          CircleAvatar(
            radius: 18.0,
            backgroundImage: AssetImage(
              'images/op_logo.jpg',
            ),
          ),
          SizedBox(
            width: 20.0,
          ),
        ],
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Text(
                  'Add Task',
                  style: headingStyle,
                ),
                InputField(
                  controller: titleController,
                  title: 'Title',
                  hint: 'Enter task title',
                ),
                InputField(
                  controller: noteController,
                  title: 'Note',
                  hint: 'Enter task note',
                ),
                InputField(
                  title: 'Date',
                  hint: DateFormat.yMd().format(selectDate),
                  widget: IconButton(
                    icon: const Icon(
                      Icons.calendar_today_outlined,
                      color: Colors.grey,
                    ),
                    onPressed: () async {
                      DateTime? date = await showDatePicker(
                        context: context,
                        initialDate: selectDate,
                        firstDate: DateTime(2016),
                        lastDate: DateTime(2040),
                      );
                      if (date != null) {
                        setState(() {
                          selectDate = date;
                        });
                      } else {
                        print('no date selected');
                      }
                    },
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: InputField(
                        title: 'Start Time',
                        hint: startTime,
                        widget: IconButton(
                          icon: const Icon(
                            Icons.access_time_rounded,
                            color: Colors.grey,
                          ),
                          onPressed: () async {
                            TimeOfDay? picStartTime = await showTimePicker(
                              context: context,
                              initialTime:
                                  TimeOfDay.fromDateTime(DateTime.now()),
                            );
                            if (picStartTime != null) {
                              setState(() {
                                startTime = picStartTime.format(context);
                              });
                            } else {
                              print('no time selected');
                            }
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: InputField(
                        title: 'End Time',
                        hint: endTime,
                        widget: IconButton(
                          icon: const Icon(
                            Icons.access_time_rounded,
                            color: Colors.grey,
                          ),
                          onPressed: () async {
                            TimeOfDay? picEndTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.fromDateTime(DateTime.now()
                                  .add(const Duration(minutes: 15))),
                            );
                            if (picEndTime != null) {
                              setState(() {
                                endTime = picEndTime.format(context);
                              });
                            } else {
                              print('no time selected');
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                InputField(
                  title: 'Remind',
                  hint: '$selectRemind minutes early',
                  widget: DropdownButton(
                    dropdownColor: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(10.0),
                    items: remindList
                        .map<DropdownMenuItem<String>>(
                          (int value) => DropdownMenuItem<String>(
                            value: value.toString(),
                            child: Text(
                              '$value',
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectRemind = int.parse(newValue!);
                      });
                    },
                    icon: const Icon(Icons.keyboard_arrow_down),
                    iconSize: 32.0,
                    elevation: 4,
                    style: subTitleStyle,
                    underline: Container(
                      height: 0.0,
                    ),
                  ),
                ),
                InputField(
                  title: 'Repeat',
                  hint: selectRepeat,
                  widget: Row(
                    children: [
                      DropdownButton(
                        dropdownColor: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(10.0),
                        items: repeatList
                            .map<DropdownMenuItem<String>>(
                              (String value) => DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectRepeat = newValue!;
                          });
                        },
                        icon: const Icon(Icons.keyboard_arrow_down),
                        iconSize: 32.0,
                        elevation: 4,
                        style: subTitleStyle,
                        underline: Container(
                          height: 0.0,
                        ),
                      ),
                    ],
                  ),
                ),
                InputField(
                  title: 'Category',
                  hint: selectCategory,
                  widget: Row(
                    children: [
                      DropdownButton(
                        dropdownColor: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(10.0),
                        items: categoryList
                            .map<DropdownMenuItem<String>>(
                              (String value) => DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectCategory = newValue!;
                          });
                        },
                        icon: const Icon(Icons.keyboard_arrow_down),
                        iconSize: 32.0,
                        elevation: 4,
                        style: subTitleStyle,
                        underline: Container(
                          height: 0.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Colors',
                            style: titleStyle,
                          ),
                          const SizedBox(
                            height: 3.0,
                          ),
                          Row(
                            children: List.generate(
                                3,
                                (index) => GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectColor = index;
                                        });
                                      },
                                      child: CircleAvatar(
                                        radius: 14.0,
                                        backgroundColor: index == 0
                                            ? primaryClr
                                            : index == 1
                                                ? pinkClr
                                                : orangeClr,
                                        child: selectColor == index
                                            ? const Icon(
                                                Icons.done,
                                                size: 16.0,
                                              )
                                            : null,
                                      ),
                                    )),
                          ),
                        ],
                      ),
                      CustomButton(
                        lable: 'create task',
                        onTap: () async {
                          if (titleController.text != '' &&
                              noteController.text != '') {
                            await addTaskToDb();
                            TaskController().getTasks();
                            Get.back();
                          } else {
                            Get.defaultDialog(
                              title: 'Requird',
                              middleText: titleController.text == '' &&
                                      noteController.text == ''
                                  ? 'please enter title and note'
                                  : noteController.text == ''
                                      ? 'Note must not be empty'
                                      : 'Title must not be empty',
                              titleStyle: const TextStyle(color: Colors.red),
                              textCancel: 'Cancel',
                              textConfirm: 'OK',
                              onConfirm: () {
                                Get.back();
                              },
                              cancelTextColor: Colors.grey,
                              confirmTextColor: Colors.white,
                              buttonColor: primaryClr,
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  addTaskToDb() async {
    dynamic value = await TaskController().addTask(
      task: Task(
        title: titleController.text,
        note: noteController.text,
        isCompleted: 0,
        date: DateFormat.yMd().format(selectDate),
        startTime: startTime,
        endTime: endTime,
        color: selectColor,
        remind: selectRemind,
        repeat: selectRepeat,
        category: selectCategory,
      ),
    );
    print(value);
  }
}
