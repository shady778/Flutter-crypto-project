import 'package:first_flutter_project/presentation/ui/ActivityScreen.dart';
import 'package:first_flutter_project/presentation/ui/MarketScreen.dart';
import 'package:first_flutter_project/presentation/ui/WalletScreen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../presentation/ui/HomeScreen.dart';
import '../../presentation/ui/SignIn.dart';
import '../../presentation/ui/SignUp.dart';
import '../../presentation/ui/MainWrapper.dart';
import '../../presentation/ui/SplashScreen.dart';
import '../../presentation/ui/OnBoardingScreen.dart';
import 'package:first_flutter_project/presentation/ui/ProfileScreen.dart';
import '../../data/Models/CoinModel.dart';
import '../../presentation/ui/DetailsScreen.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => Splashscreen(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => OnBoardingScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/signup',
        builder: (context, state) => const Signup(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) {
          return MainWrapper(child: child);
        },
        routes: [
          GoRoute(
            path: '/home',
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: '/market',
            builder: (context, state) => const MarketScreen(),
          ),
          GoRoute(
            path: '/activity',
            builder: (context, state) => const ActivityScreen(),
          ),
          GoRoute(
            path: '/wallets',
            builder: (context, state) => const WalletScreen(),
          ),
        ],
      ),
      GoRoute(
        path: '/details',
        builder: (context, state) {
          final coin = state.extra as CoinModel;
          return DetailsScreen(coin: coin);
        },
      ),
    ],
  );
}