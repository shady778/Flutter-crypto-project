import 'dart:async';
import 'package:first_flutter_project/presentation/colors/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/app_cubit.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 2), () {
      if (mounted) {
        final isLoggedIn = context.read<AppCubit>().state.isLoggedIn;
        if (isLoggedIn) {
          context.go('/home');
        } else {
          context.go('/onboarding');
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 66.65),
              child: Image.asset(
                "assets/images/Splashicon.png",
                errorBuilder: (context, error, stackTrace) => const Icon(Icons.flash_on, size: 100, color: AppColors.primaryMint),
              ),
            ),
            Image.asset(
              "assets/images/splash2.png",
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(height: 200, color: AppColors.darkSurface),
            )
          ],
        ),
      ),
    );
  }
}