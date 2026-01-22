import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timesync_flutter/core/animations/animation_utils.dart';
import 'package:timesync_flutter/core/constants/app_colors.dart';
import 'package:timesync_flutter/core/constants/app_text_styles.dart';
import 'package:timesync_flutter/presentation/navigation/main_navigation.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen>
    with TickerProviderStateMixin {
  late PageController _pageController;
  int _currentPage = 0;

  final List<OnboardingPage> pages = [
    OnboardingPage(
      title: 'TimeSync\'e Hoşgeldiniz',
      description: 'Randevu yönetimini kolaylaştırın ve müşteri memnuniyetini artırın',
      icon: Icons.calendar_today,
      gradient: LinearGradient(
        colors: [AppColors.primaryLight.withOpacity(0.1), Colors.transparent],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    OnboardingPage(
      title: 'Akıllı Planlama',
      description: 'Otomatik randevu sistemimizle zamanı verimli kullanın',
      icon: Icons.schedule,
      gradient: LinearGradient(
        colors: [AppColors.accentPurple.withOpacity(0.1), Colors.transparent],
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
      ),
    ),
    OnboardingPage(
      title: 'Müşteri Yönetimi',
      description: 'Müşteri verilerini merkezi olarak yönetin ve müşteri memnuniyetini ölçün',
      icon: Icons.people,
      gradient: LinearGradient(
        colors: [Colors.green.withOpacity(0.1), Colors.transparent],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    OnboardingPage(
      title: 'Başlamaya Hazır',
      description: 'Şimdi başlayalım ve işletmenizi geliştirelik',
      icon: Icons.rocket_launch,
      gradient: LinearGradient(
        colors: [Colors.orange.withOpacity(0.1), Colors.transparent],
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: SafeArea(
        child: Column(
          children: [
            // Page View
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() => _currentPage = index);
                },
                itemCount: pages.length,
                itemBuilder: (context, index) {
                  return _buildPage(pages[index], index);
                },
              ),
            ),

            // Indicators and Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Column(
                children: [
                  // Dot Indicators
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int i = 0; i < pages.length; i++)
                        GestureDetector(
                          onTap: () {
                            _pageController.animateToPage(
                              i,
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeInOutCubic,
                            );
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: _currentPage == i ? 28 : 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: _currentPage == i
                                  ? AppColors.primaryLight
                                  : Colors.grey.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // Buttons Row
                  Row(
                    children: [
                      // Skip/Back Button
                      if (_currentPage < pages.length - 1)
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              if (_currentPage > 0) {
                                _pageController.previousPage(
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.easeInOutCubic,
                                );
                              } else {
                                _skipOnboarding();
                              }
                            },
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              side: BorderSide(
                                color: AppColors.primaryLight.withOpacity(0.3),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              _currentPage == 0 ? 'Atla' : 'Geri',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryLight,
                              ),
                            ),
                          ),
                        ),
                      if (_currentPage < pages.length - 1) const SizedBox(width: 12),
                      // Next Button
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (_currentPage == pages.length - 1) {
                              _skipOnboarding();
                            } else {
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 400),
                                curve: Curves.easeInOutCubic,
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryLight,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            _currentPage == pages.length - 1 ? 'Başla' : 'İleri',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPage(OnboardingPage page, int index) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 60),

          // Icon with gradient background
          ScaleFadeAnimation(
            duration: AppAnimations.slow,
            child: Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: page.gradient,
                border: Border.all(
                  color: AppColors.primaryLight.withOpacity(0.2),
                  width: 2,
                ),
              ),
              child: Icon(
                page.icon,
                size: 70,
                color: AppColors.primaryLight,
              ),
            ),
          ),

          const SizedBox(height: 48),

          // Title
          FadeInAnimation(
            duration: AppAnimations.normal,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                page.title,
                textAlign: TextAlign.center,
                style: AppTextStyles.headlineSmall.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 28,
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Description
          SlideInAnimation(
            duration: AppAnimations.medium,
            begin: const Offset(0, 0.3),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                page.description,
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyLarge.copyWith(
                  color: Colors.grey[400],
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
            ),
          ),

          const SizedBox(height: 60),

          // Feature List (for some pages)
          if (index < 3)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                children: [
                  for (int i = 0; i < 2; i++)
                    SlideInAnimation(
                      duration: AppAnimations.normal,
                      delay: Duration(milliseconds: 200 * (i + 1)),
                      begin: const Offset(0.5, 0),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: _buildFeatureItem(
                          icon: _getFeatureIcon(index, i),
                          title: _getFeatureTitle(index, i),
                          subtitle: _getFeatureSubtitle(index, i),
                        ),
                      ),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.primaryLight.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: AppColors.primaryLight,
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.titleSmall.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: AppTextStyles.caption.copyWith(
                    color: Colors.grey[500],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconData _getFeatureIcon(int pageIndex, int itemIndex) {
    switch (pageIndex) {
      case 0:
        return itemIndex == 0 ? Icons.check_circle : Icons.star;
      case 1:
        return itemIndex == 0 ? Icons.speed : Icons.notifications;
      case 2:
        return itemIndex == 0 ? Icons.security : Icons.analytics;
      default:
        return Icons.info;
    }
  }

  String _getFeatureTitle(int pageIndex, int itemIndex) {
    switch (pageIndex) {
      case 0:
        return itemIndex == 0 ? 'Kolay Kullanım' : 'Premium Özellikler';
      case 1:
        return itemIndex == 0 ? 'Hızlı İşlem' : 'Uyarı Sistemi';
      case 2:
        return itemIndex == 0 ? 'Güvenli Veri' : 'Detaylı Raporlar';
      default:
        return 'Özellik';
    }
  }

  String _getFeatureSubtitle(int pageIndex, int itemIndex) {
    switch (pageIndex) {
      case 0:
        return itemIndex == 0
            ? 'Herkesin kullanabileceği arayüz'
            : 'Ekstra fonksiyonlar içerir';
      case 1:
        return itemIndex == 0
            ? 'Saniyeler içinde işlem yapın'
            : 'Müşterilere otomatik bildir';
      case 2:
        return itemIndex == 0
            ? 'Şifrelenmiş depolama'
            : 'Performans analizi';
      default:
        return '';
    }
  }

  void _skipOnboarding() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const MainNavigation(),
      ),
    );
  }
}

class OnboardingPage {
  final String title;
  final String description;
  final IconData icon;
  final LinearGradient gradient;

  OnboardingPage({
    required this.title,
    required this.description,
    required this.icon,
    required this.gradient,
  });
}
