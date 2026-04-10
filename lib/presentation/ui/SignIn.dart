
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../colors/AppColors.dart';
import '../Widgets/CustomInputField.dart';
import '../Widgets/CustomTopTabs.dart';
import '../Widgets/MainButton.dart';
import '../Widgets/SocialButton.dart';
import '../cubits/app_cubit.dart';
import '../cubits/app_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields")),
      );
      return;
    }

    final success = await context.read<AppCubit>().login(
      _emailController.text,
      _passwordController.text,
    );

    if (success && mounted) {
      context.go('/home');
    } else if (mounted) {
      final error = context.read<AppCubit>().state.authError ?? "Invalid Email or Password";
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              const CustomTopTabs(isSignIn: true),
              const SizedBox(height: 40),
              const Text(
                "Sign in",
                style: TextStyle(
                  color: AppColors.textWhite,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              CustomInputField(
                controller: _emailController,
                hint: "Enter your email",
                isPassword: false,
                suffixIcon: Icons.email_outlined,
              ),
              const SizedBox(height: 16),
              CustomInputField(
                controller: _passwordController,
                hint: "Enter your password",
                isPassword: true,
                suffixIcon: Icons.visibility_off_outlined,
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {},
                child: const Text(
                  "Forgot password?",
                  style: TextStyle(color: AppColors.primaryMint),
                ),
              ),
              const SizedBox(height: 20),
              BlocBuilder<AppCubit, AppState>(
                builder: (context, state) {
                  return Mainbutton(
                    text: state.isAuthLoading ? "Loading..." : "Sign in",
                    OnPressed: state.isAuthLoading ? () {} : _login,
                  );
                },
              ),
              const SizedBox(height: 30),
              const Center(
                child: Text(
                  "Or login with",
                  style: TextStyle(color: AppColors.textGrey),
                ),
              ),
              const SizedBox(height: 20),
              const Row(
                children: [
                  SocialButton(label: "Facebook", iconPath: "assets/images/facebookicon.png"),
                  SizedBox(width: 12),
                  SocialButton(label: "Google", iconPath: "assets/images/Googleicon.png"),
                ],
              ),
              const SizedBox(height: 40),
              const Center(
                child: Column(
                  children: [
                    Icon(Icons.fingerprint, color: AppColors.primaryMint, size: 60),
                    SizedBox(height: 10),
                    Text(
                      "Use fingerprint instead?",
                      style: TextStyle(color: AppColors.textGrey),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}