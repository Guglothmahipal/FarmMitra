import 'package:farmmitra_app/config/routing/app_routes.dart';
import 'package:farmmitra_app/features/auth/presentation/controllers/auth_providers.dart';
import 'package:farmmitra_app/features/auth/presentation/controllers/onboarding_controller.dart';
import 'package:farmmitra_app/shared/widgets/app_primary_button.dart';
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

  static const _pages = [
    _OnboardingSlide(
      icon: Icons.agriculture,
      title: 'Farm work made simple',
      description: 'Post farm jobs, find local workers and manage work faster.',
    ),
    _OnboardingSlide(
      icon: Icons.wb_sunny_outlined,
      title: 'Weather and mandi updates',
      description: 'Stay ready for rain, crop alerts and market price changes.',
    ),
    _OnboardingSlide(
      icon: Icons.offline_bolt_outlined,
      title: 'Works even in low network',
      description: 'Your profile, jobs and applications stay saved locally.',
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
    final pageIndex = ref.watch(onboardingPageIndexProvider);
    final isLastPage = pageIndex == _pages.length - 1;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: _finish,
                  child: const Text('Skip'),
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _pages.length,
                  onPageChanged: (index) {
                    ref
                        .read(onboardingPageIndexProvider.notifier)
                        .setPage(index);
                  },
                  itemBuilder: (context, index) => _pages[index],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _pages.length,
                  (index) => _PageDot(isActive: index == pageIndex),
                ),
              ),
              const SizedBox(height: 22),
              AppPrimaryButton(
                label: isLastPage ? 'Get Started' : 'Next',
                icon: isLastPage ? Icons.check : Icons.arrow_forward,
                onPressed: isLastPage ? _finish : _nextPage,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 240),
      curve: Curves.easeOut,
    );
  }

  Future<void> _finish() async {
    await ref.read(authControllerProvider.notifier).completeOnboarding();
    if (mounted) {
      context.go(AppRoutes.roleSelection);
    }
  }
}

class _OnboardingSlide extends StatelessWidget {
  const _OnboardingSlide({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: scheme.primaryContainer,
            borderRadius: BorderRadius.circular(32),
          ),
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Icon(icon, size: 76, color: scheme.onPrimaryContainer),
          ),
        ),
        const SizedBox(height: 32),
        Text(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 12),
        Text(
          description,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: scheme.onSurfaceVariant,
            height: 1.35,
          ),
        ),
      ],
    );
  }
}

class _PageDot extends StatelessWidget {
  const _PageDot({required this.isActive});

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      width: isActive ? 28 : 8,
      height: 8,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: isActive ? scheme.primary : scheme.outlineVariant,
        borderRadius: BorderRadius.circular(99),
      ),
    );
  }
}
