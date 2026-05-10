import 'package:farmmitra_app/features/onboarding/presentation/models/onboarding_slide.dart';
import 'package:flutter/material.dart';

class OnboardingSlideView extends StatelessWidget {
  const OnboardingSlideView({
    required this.slide,
    required this.pageOffset,
    super.key,
  });

  final OnboardingSlide slide;
  final double pageOffset;

  @override
  Widget build(BuildContext context) {
    final progress = pageOffset.abs().clamp(0.0, 1.0);
    final opacity = 1 - (progress * 0.34);
    final scale = 1 - (progress * 0.05);

    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFF6FFF1), Color(0xFFE5F5D9)],
        ),
      ),
      child: Align(
        alignment: Alignment.topCenter,
        child: Transform.scale(
          scale: scale,
          child: Opacity(
            opacity: opacity,
            child: Image.asset(
              slide.imageAsset,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
            ),
          ),
        ),
      ),
    );
  }
}
