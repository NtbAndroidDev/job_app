import 'package:flutter/material.dart';
import 'package:jobhub/constants/app_constants.dart';
import 'package:jobhub/views/common/app_style.dart';
import 'package:jobhub/views/common/reusable_text.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.text, this.colors, this.onTap});

  final String text;
  final Color? colors;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Color(kOrange.value),

          ),
          width: width,
          height: height*0.065,
          child: Center(
            child: ReusableText(text: text, style: appstyle(16, colors?? Color(kLight.value), FontWeight.w600)),
          ),
        ));
  }
}
