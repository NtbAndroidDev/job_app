import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jobhub/constants/app_constants.dart';
import 'package:jobhub/views/common/app_style.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key, required this.controller, required this.hintText, required this.keyboardType, this.validator, this.suffixIcon, this.obscureText});

  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final bool? obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      obscureText: obscureText??false,
      decoration: InputDecoration(
          filled: true,
          fillColor: Color(kLightGrey.value),
        hintText: hintText,
        suffixIcon: suffixIcon,
        hintStyle: appstyle(14, Color(kDarkGrey.value), FontWeight.w500),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(color: Colors.red, width: 1)
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(color: Colors.black, width: 1)
        ),
        focusedErrorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(color: Colors.red, width: 1)
        ),
        disabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(color: Color(kDarkGrey.value), width: 0.5)
        ),
        enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(color: Colors.transparent, width: 0.5)
        ),
        border: InputBorder.none
      ),
      controller: controller,
      cursorHeight: 25,
      style: appstyle(14, Color(kDark.value), FontWeight.w500),
      validator: validator,
    );
  }
}