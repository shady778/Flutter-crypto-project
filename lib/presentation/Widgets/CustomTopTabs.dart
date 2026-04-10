import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../colors/AppColors.dart';

class CustomTopTabs extends StatelessWidget {
  final bool isSignIn;

  const CustomTopTabs({super.key, required this.isSignIn});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.tabSwitchBg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // --- Tab 1: Sign In ---
          Expanded(
            child: GestureDetector(
              onTap: () {
                if (!isSignIn) context.push('/login'); // Law msh feha, ro7-lha
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: isSignIn ? AppColors.activeTabBg : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    "Sign in",
                    style: TextStyle(
                      color: isSignIn ? Colors.white : AppColors.textGrey,
                      fontWeight: isSignIn ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // --- Tab 2: Sign Up ---
          Expanded(
            child: GestureDetector(
              onTap: () {
                if (isSignIn) context.push('/signup'); // Law msh feha, ro7-lha
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: !isSignIn ? AppColors.activeTabBg : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    "Sign up",
                    style: TextStyle(
                      color: !isSignIn ? Colors.white : AppColors.textGrey,
                      fontWeight: !isSignIn ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}