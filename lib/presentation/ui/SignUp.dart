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

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void _signup() async {
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields")),
      );
      return;
    }

    final success = await context.read<AppCubit>().signup(
      _nameController.text,
      _emailController.text,
      _passwordController.text,
    );

    if (success && mounted) {
      context.go('/login');
    } else if (mounted) {
      final error = context.read<AppCubit>().state.authError ?? "Signup Failed. Email might be taken.";
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
              const CustomTopTabs(isSignIn: false),
              const SizedBox(height: 40),
              const Text(
                "Sign up",
                style: TextStyle(
                  color: AppColors.textWhite,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              CustomInputField(
                controller: _nameController,
                hint: "Enter your name",
                isPassword: false,
                suffixIcon: Icons.person_outline,
              ),
              const SizedBox(height: 16),
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
              const SizedBox(height: 30),
              BlocBuilder<AppCubit, AppState>(
                builder: (context, state) {
                  return Mainbutton(
                    text: state.isAuthLoading ? "Loading..." : "Sign up",
                    OnPressed: state.isAuthLoading ? () {} : _signup,
                  );
                },
              ),
              const SizedBox(height: 30),
              const Center(
                child: Text(
                  "Or Signup with",
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
            ],
          ),
        ),
      ),
    );
  }
}