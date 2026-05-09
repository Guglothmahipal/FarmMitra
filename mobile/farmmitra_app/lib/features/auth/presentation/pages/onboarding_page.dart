import 'package:farmmitra_app/config/routing/app_routes.dart';
import 'package:farmmitra_app/features/auth/presentation/controllers/auth_providers.dart';
import 'package:farmmitra_app/features/auth/presentation/controllers/onboarding_controller.dart';
import 'package:farmmitra_app/shared/widgets/app_primary_button.dart';
import 'package:farmmitra_app/shared/widgets/voice_instruction_button.dart';
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
      icon: Icons.offline_bolt_outlined,
      title: 'Works in low network',
      description:
          'Important profile, job, and application details stay available on this phone.',
    ),
    _OnboardingSlide(
      icon: Icons.location_on_outlined,
      title: 'Find nearby jobs and workers',
      description:
          'Farmers can post village work. Workers can discover local farm jobs.',
    ),
    _OnboardingSlide(
      icon: Icons.wb_sunny_outlined,
      title: 'Weather alerts ready',
      description:
          'Weather and farm planning alerts will connect as the platform grows.',
    ),
    _OnboardingSlide(
      icon: Icons.translate_outlined,
      title: 'Local language support',
      description:
          'Choose your comfortable language now. More translations will be added step by step.',
    ),
    _OnboardingSlide(
      icon: Icons.volume_up_outlined,
      title: 'Voice assistance ready',
      description:
          'Speaker buttons can guide users who prefer hearing instructions.',
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
                alignment: Alignment.center,
                child: Row(
                  children: [
                    Expanded(
                      child: VoiceInstructionButton(
                        instruction: _pages[pageIndex].description,
                      ),
                    ),
                    TextButton(onPressed: _finish, child: const Text('Skip')),
                  ],
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
              const SizedBox(height: 20),
              AppPrimaryButton(
                label: isLastPage ? 'Get started' : 'Next',
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
      duration: const Duration(milliseconds: 250),
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
        CircleAvatar(
          radius: 52,
          backgroundColor: scheme.primaryContainer,
          foregroundColor: scheme.onPrimaryContainer,
          child: Icon(icon, size: 48),
        ),
        const SizedBox(height: 28),
        Text(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 12),
        Text(
          description,
          textAlign: TextAlign.center,
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(color: scheme.onSurfaceVariant),
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
      duration: const Duration(milliseconds: 200),
      width: isActive ? 24 : 8,
      height: 8,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: isActive ? scheme.primary : scheme.outlineVariant,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
