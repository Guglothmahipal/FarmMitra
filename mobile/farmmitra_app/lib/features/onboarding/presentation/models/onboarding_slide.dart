import 'package:farmmitra_app/l10n/app_localizations.dart';

final class OnboardingSlide {
  const OnboardingSlide({
    required this.title,
    required this.description,
    required this.imageAsset,
  });

  final String title;
  final String description;
  final String imageAsset;
}

List<OnboardingSlide> buildOnboardingSlides(AppLocalizations l10n) {
  return [
    OnboardingSlide(
      title: l10n.onboardingSlide1Title,
      description: l10n.onboardingSlide1Description,
      imageAsset: 'assets/onboarding/webp/Feature_1.webp',
    ),
    OnboardingSlide(
      title: l10n.onboardingSlide2Title,
      description: l10n.onboardingSlide2Description,
      imageAsset: 'assets/onboarding/webp/Feature_2.webp',
    ),
    OnboardingSlide(
      title: l10n.onboardingSlide3Title,
      description: l10n.onboardingSlide3Description,
      imageAsset: 'assets/onboarding/webp/Feature_3.webp',
    ),
    OnboardingSlide(
      title: l10n.onboardingSlide4Title,
      description: l10n.onboardingSlide4Description,
      imageAsset: 'assets/onboarding/webp/Feature_4.webp',
    ),
  ];
}

const onboardingImageAssets = [
  'assets/onboarding/webp/Feature_1.webp',
  'assets/onboarding/webp/Feature_2.webp',
  'assets/onboarding/webp/Feature_3.webp',
  'assets/onboarding/webp/Feature_4.webp',
];
