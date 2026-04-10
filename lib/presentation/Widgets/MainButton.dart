import 'package:first_flutter_project/presentation/colors/AppColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Mainbutton extends StatelessWidget{
  final String text;
  final VoidCallback OnPressed;
  const Mainbutton({super.key,required this.text,required this.OnPressed});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: OnPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryMint,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(12)),
          elevation: 0,
        ),
        child: Text(
          text,
          style: TextStyle(
            color: AppColors.textBlack,
            fontWeight: FontWeight.bold,
            fontSize: 16
          ),
        ),
      ),
    );
  }
  
}