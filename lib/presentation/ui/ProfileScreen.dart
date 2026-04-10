import 'package:flutter/material.dart';
import '../colors/AppColors.dart';
import '../Widgets/SettingItem.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/app_cubit.dart';
import '../cubits/app_state.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        String userName = state.userName;
        String userEmail = state.userEmail;

        if (userName.isEmpty) userName = "Guest User";
        if (userEmail.isEmpty) userEmail = "guest@email.com";
        String usernameHandle = "@${userName.replaceAll(' ', '').toLowerCase()}";

        return Scaffold(
          backgroundColor: AppColors.scaffoldBg,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: const BackButton(color: Colors.white),
            title: const Text("Profile", style: TextStyle(color: Colors.white)),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                const Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/images/user.png'),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  userName,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text(
                  usernameHandle,
                  style: const TextStyle(color: Colors.grey, fontSize: 16),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SettingItem(
                      icon: Icons.person_outline,
                      title: "Full Name",
                      trailing: userName),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SettingItem(
                      icon: Icons.email_outlined,
                      title: "Email",
                      trailing: userEmail),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SettingItem(
                      icon: Icons.phone_outlined,
                      title: "Phone",
                      trailing: "+1 234 567 890"),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SettingItem(
                      icon: Icons.location_on_outlined,
                      title: "Location",
                      trailing: "New York, USA"),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      await context.read<AppCubit>().logout();
                      if (context.mounted) {
                        context.go('/login');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent.withOpacity(0.1),
                      foregroundColor: Colors.redAccent,
                      elevation: 0,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: const BorderSide(color: Colors.redAccent),
                      ),
                    ),
                    icon: const Icon(Icons.logout),
                    label: const Text(
                      "Logout",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
