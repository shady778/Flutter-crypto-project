import 'package:first_flutter_project/presentation/colors/AppColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OnBoardingButton extends StatelessWidget{
  final String text;
  final VoidCallback onpressed;
  const OnBoardingButton({super.key,required this.text,required this.onpressed});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      height: 54,
      child: ElevatedButton(onPressed: onpressed,
          child: Text(text,
            style: TextStyle(fontSize: 20,color: AppColors.darkBackground),
          ),
      style: ButtonStyle(backgroundColor: WidgetStateProperty.all( AppColors.primaryMint),),
    )

    ) ;
  }

}