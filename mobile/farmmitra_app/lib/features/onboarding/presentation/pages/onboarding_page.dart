import 'package:farmmitra_app/config/routing/app_routes.dart';
import 'package:farmmitra_app/core/localization/locale_extensions.dart';
import 'package:farmmitra_app/features/auth/presentation/controllers/auth_providers.dart';
import 'package:farmmitra_app/features/onboarding/presentation/controllers/onboarding_controller.dart';
import 'package:farmmitra_app/features/onboarding/presentation/models/onboarding_slide.dart';
import 'package:farmmitra_app/features/onboarding/presentation/widgets/onboarding_content_panel.dart';
import 'package:farmmitra_app/features/onboarding/presentation/widgets/onboarding_slide_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class OnboardingPage extends ConsumerStatefulWidget {
  const OnboardingPage({super.key});

  @override
  ConsumerState<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends ConsumerState<OnboardingPage> {
  late final PageController _pageController;
  bool _didPrecache = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_didPrecache) {
      return;
    }

    _didPrecache = true;
    for (final imageAsset in onboardingImageAssets) {
      precacheImage(AssetImage(imageAsset), context);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pageIndex = ref.watch(onboardingPageIndexProvider);
    final l10n = context.l10n;
    final slides = buildOnboardingSlides(l10n);
    final slide = slides[pageIndex];
    final isLastPage = pageIndex == slides.length - 1;

    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            allowImplicitScrolling: true,
            itemCount: slides.length,
            onPageChanged: (index) {
              ref.read(onboardingPageIndexProvider.notifier).setPage(index);
            },
            itemBuilder: (context, index) {
              return AnimatedBuilder(
                animation: _pageController,
                builder: (context, _) {
                  final currentPage =
                      _pageController.hasClients &&
                          _pageController.position.haveDimensions
                      ? _pageController.page ?? pageIndex.toDouble()
                      : pageIndex.toDouble();

                  return OnboardingSlideView(
                    slide: slides[index],
                    pageOffset: currentPage - index,
                  );
                },
              );
            },
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 10, right: 16),
                child: TextButton(
                  onPressed: _finish,
                  style: TextButton.styleFrom(
                    foregroundColor: const Color(0xFF245E32),
                    textStyle: const TextStyle(fontWeight: FontWeight.w800),
                  ),
                  child: Text(l10n.commonSkip),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 260),
              switchInCurve: Curves.easeOutCubic,
              switchOutCurve: Curves.easeInCubic,
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0.04, 0),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  ),
                );
              },
              child: OnboardingContentPanel(
                key: ValueKey(slide.title),
                title: slide.title,
                description: slide.description,
                pageCount: slides.length,
                activeIndex: pageIndex,
                buttonLabel: isLastPage
                    ? l10n.commonGetStarted
                    : l10n.commonNext,
                buttonIcon: isLastPage ? Icons.check : Icons.arrow_forward,
                onPressed: isLastPage ? _finish : _nextPage,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 420),
      curve: Curves.easeInOutCubic,
    );
  }

  Future<void> _finish() async {
    await ref.read(authControllerProvider.notifier).completeOnboarding();
    if (mounted) {
      context.go(AppRoutes.roleSelection);
    }
  }
}
