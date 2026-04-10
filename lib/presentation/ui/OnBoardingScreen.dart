import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../colors/AppColors.dart';
import '../Widgets/OnBoardingButton.dart';
import '../../data/Repositories/AppRepo.dart';
import '../../core/local/DbHelper.dart';

class OnBoardingData {
  final String image;
  final String title;
  final String desc;

  OnBoardingData({required this.image, required this.title, required this.desc});
}

List<OnBoardingData> onboardingContents = [
  OnBoardingData(
    image: "assets/images/onboarding1.png",
    title: "Trade anytime anywhere",
    desc: "Lorem ipsum dolor sit amet, consectetur adipiscing elit...",
  ),
  OnBoardingData(
    image: "assets/images/onboarding2.png",
    title: "Save and invest at the same time ",
    desc: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore.",
  ),
  OnBoardingData(
    image: "assets/images/onboarding3.png",
    title: "Transact fast and easy",
    desc: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore.",
  ),
];

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int currentIndex = 0;
  final PageController _pageController = PageController();
  late AppRepo _appRepo;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _appRepo = RepositoryProvider.of<AppRepo>(context);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemCount: onboardingContents.length,
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Image.asset(
                        onboardingContents[index].image,
                        errorBuilder: (context, error, stackTrace) => const Icon(Icons.image_not_supported, size: 100, color: AppColors.grey),
                      ),
                    ),
                    Text(
                      onboardingContents[index].title,
                      style: const TextStyle(
                        fontSize: 24,
                        color: AppColors.textWhite,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text(
                        onboardingContents[index].desc,
                        style: const TextStyle(
                          fontSize: 18,
                          color: AppColors.textGrey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              onboardingContents.length,
                  (index) => Container(
                margin: const EdgeInsets.only(right: 8),
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: currentIndex == index ? AppColors.grey : AppColors.lonlkora,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(40),
            child: OnBoardingButton(
              onpressed: () {
                if (currentIndex < onboardingContents.length - 1) {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                } else {
                  if (_appRepo.checkUserLoggedIn()) {
                    context.go('/home');
                  } else {
                    context.go('/login');
                  }
                }
              },
              text: currentIndex == onboardingContents.length - 1 ? "Start" : "Next",
            ),
          ),
        ],
      ),
    );
  }
}