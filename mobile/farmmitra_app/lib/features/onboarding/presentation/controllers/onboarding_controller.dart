import 'package:flutter_riverpod/flutter_riverpod.dart';

final onboardingPageIndexProvider =
    NotifierProvider<OnboardingPageIndexController, int>(
      OnboardingPageIndexController.new,
    );

final class OnboardingPageIndexController extends Notifier<int> {
  @override
  int build() => 0;

  void setPage(int index) {
    state = index;
  }
}
