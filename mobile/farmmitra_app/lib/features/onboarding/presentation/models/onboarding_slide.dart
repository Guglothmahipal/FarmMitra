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

const onboardingSlides = [
  OnboardingSlide(
    title: 'Find trusted farm workers',
    description:
        'Connect with nearby verified workers for harvesting, irrigation, spraying and daily farm activities.',
    imageAsset: 'assets/onboarding/webp/Feature_1.webp',
  ),
  OnboardingSlide(
    title: 'Manage farm work in one place',
    description:
        'Check weather, post labour jobs, find nearby workers and track responses from your village area.',
    imageAsset: 'assets/onboarding/webp/Feature_2.webp',
  ),
  OnboardingSlide(
    title: 'Buy farming essentials nearby',
    description:
        'Discover fertilizers, pesticides, seeds and tools from nearby agricultural vendors.',
    imageAsset: 'assets/onboarding/webp/Feature_3.webp',
  ),
  OnboardingSlide(
    title: 'AI help and farming updates',
    description:
        'Get AI-ready farming guidance, weather alerts, crop updates and local agriculture news in one place.',
    imageAsset: 'assets/onboarding/webp/Feature_4.webp',
  ),
];
