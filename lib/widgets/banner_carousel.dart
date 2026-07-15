import 'dart:async';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../theme/app_theme.dart';

/// A single promotional banner shown in the [BannerCarousel].
class BannerItem {
  final String title;
  final String subtitle;
  final List<Color> gradient;
  final String emoji;

  const BannerItem({
    required this.title,
    required this.subtitle,
    required this.gradient,
    required this.emoji,
  });
}

/// Auto-scrolling carousel of discount/festival/promo banners on Home.
/// Uses gradient cards instead of network images so it always renders
/// nicely even without network access.
class BannerCarousel extends StatefulWidget {
  const BannerCarousel({super.key});

  @override
  State<BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {
  final PageController _controller = PageController();
  Timer? _timer;
  int _currentPage = 0;

  final List<BannerItem> _banners = const [
    BannerItem(
      title: 'Flat 50% OFF',
      subtitle: 'On your first order today',
      gradient: [Color(0xFFFF6B35), Color(0xFFFF8F65)],
      emoji: '🎉',
    ),
    BannerItem(
      title: 'Festival Special',
      subtitle: 'Up to 70% off on Fashion & Electronics',
      gradient: [Color(0xFF2EC4B6), Color(0xFF5FE0D2)],
      emoji: '🪔',
    ),
    BannerItem(
      title: 'Free Delivery',
      subtitle: 'On orders above ₹299',
      gradient: [Color(0xFF6C5CE7), Color(0xFF9C8CFF)],
      emoji: '🚚',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!mounted) return;
      _currentPage = (_currentPage + 1) % _banners.length;
      _controller.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 450),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 130,
          child: PageView.builder(
            controller: _controller,
            itemCount: _banners.length,
            onPageChanged: (i) => setState(() => _currentPage = i),
            itemBuilder: (context, index) {
              final banner = _banners[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppRadius.lg),
                    gradient: LinearGradient(
                      colors: banner.gradient,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              banner.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              banner.subtitle,
                              style: const TextStyle(color: Colors.white, fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                      Text(banner.emoji, style: const TextStyle(fontSize: 42)),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        SmoothPageIndicator(
          controller: _controller,
          count: _banners.length,
          effect: const WormEffect(
            dotHeight: 6,
            dotWidth: 6,
            activeDotColor: AppColors.primary,
            dotColor: AppColors.border,
          ),
        ),
      ],
    );
  }
}
