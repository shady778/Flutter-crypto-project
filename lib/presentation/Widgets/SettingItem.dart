import 'package:first_flutter_project/presentation/colors/AppColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String trailing;

  const SettingItem({ super.key,
    required this.icon,
    required this.title,
    required this.trailing});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: AppColors.tabSwitchBg,borderRadius: BorderRadius.circular(10),),
        child: Icon(icon,color: AppColors.primaryMint,size: 20),
      ),
        title: Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              trailing,
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
          ],
        ),
        onTap: () {},
      );
    }
}

