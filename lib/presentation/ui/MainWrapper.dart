import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../colors/AppColors.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/app_cubit.dart';
import '../cubits/app_state.dart';
import '../Widgets/CoinSearchDelegate.dart';

class MainWrapper extends StatelessWidget {
  final Widget child;

  const MainWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1D2733),
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(5),
          child: GestureDetector(
            onTap: () => context.push('/profile'),
            child: const CircleAvatar(
              backgroundImage: AssetImage('assets/images/user.png'),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocBuilder<AppCubit, AppState>(
              builder: (context, state) {
                return IconButton(
                  icon: SvgPicture.asset(
                    "assets/images/search.svg",
                    width: 40,
                    height: 40,
                  ),
                  onPressed: () {
                    showSearch(
                      context: context,
                      delegate: CoinSearchDelegate(state.marketCoins),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: SvgPicture.asset(
                "assets/images/catigories.svg",
                width: 40,
                height: 40,
              ),
              onPressed: () {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: SvgPicture.asset(
                "assets/images/notification.svg",
                width: 40,
                height: 40,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          child,
          Align(
            alignment: Alignment.bottomCenter,
            child: _buildFloatingNavBar(context),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingNavBar(BuildContext context) {
    return Container(
      height: 75,
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 25),
      decoration: BoxDecoration(
        color: const Color(0xFF28333F),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 15,
            spreadRadius: 2,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _navItem(context, Icons.home_filled, "Home", '/home'),
          _navItem(context, Icons.shopping_bag_outlined, "Markets", '/market'),
          _navItem(context, Icons.analytics_outlined, "Activity", '/activity'),
          _navItem(context, Icons.wallet_outlined, "Wallets", '/wallets'),
        ],
      ),
    );
  }

  Widget _navItem(
    BuildContext context,
    IconData icon,
    String label,
    String route,
  ) {
    final bool isActive = GoRouterState.of(context).uri.path.startsWith(route);
    final Color color = isActive
        ? const Color(0xFF5CE1AD)
        : const Color(0xFF8D99A9);

    return GestureDetector(
      onTap: () => context.go(route),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isActive
              ? const Color(0xFF5CE1AD).withOpacity(0.12)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: isActive ? 30 : 26),
            const SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
