import 'package:flutter/material.dart';
import 'package:first_flutter_project/presentation/Widgets/SettingItem.dart';
import 'package:first_flutter_project/presentation/colors/AppColors.dart';

class SettingScreen extends StatelessWidget{
  const SettingScreen({super.key});
  @override
  Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: AppColors.scaffoldBg,
    appBar: AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: const Icon(Icons.arrow_back, color: Colors.white),
      title: const Text("Settings", style: TextStyle(color: Colors.white)),
    ),
    body: Padding(
        padding:const EdgeInsetsGeometry.symmetric(vertical: 20),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const SettingItem(icon: Icons.language, title: "Language", trailing: "English"),
                ),


                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const SettingItem(icon: Icons.monetization_on_outlined, title: "Currency", trailing: "USD"),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const SettingItem(icon: Icons.wb_sunny_outlined, title: "Appearance", trailing: "Use Device Settings"),
                ),


                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const SettingItem(icon: Icons.tune, title: "Preference", trailing: "Customize"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const SettingItem(icon: Icons.group_outlined, title: "About Us", trailing: "V1.1"),
                )
              ],

    ),
    ),
  );
  }
  
}