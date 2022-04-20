import 'package:flutter/material.dart';
import 'package:to_do/ui/theme.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({Key? key, required this.lable, required this.onTap})
      : super(key: key);
  final String lable;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: 100.0,
        height: 45.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: primaryClr,
        ),
        child: Text(
          lable,
          style: const TextStyle(
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
