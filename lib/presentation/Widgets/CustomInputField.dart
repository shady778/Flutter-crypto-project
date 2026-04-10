import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../colors/AppColors.dart';

class CustomInputField extends StatelessWidget{
  final String hint;
  final bool isPassword;
  final IconData? suffixIcon;
  final TextEditingController controller;
  const CustomInputField({super.key,required this.hint,required this.isPassword,required this.suffixIcon, required this.controller});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText:isPassword,
      style:const TextStyle(color:AppColors.textWhite),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: AppColors.textGrey,fontSize: 14),
        filled:true,
        fillColor: AppColors.tabSwitchBg,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        suffixIcon: suffixIcon != null
            ? Icon(suffixIcon, color: Colors.grey, size: 20)
            : null,

      ),

    );
  }

}
