import 'package:farmmitra_app/core/constants/app_constants.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(28),
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: 1),
              duration: const Duration(milliseconds: 450),
              builder: (context, value, child) {
                return Opacity(
                  opacity: value,
                  child: Transform.translate(
                    offset: Offset(0, 10 * (1 - value)),
                    child: child,
                  ),
                );
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: scheme.primaryContainer,
                      borderRadius: BorderRadius.circular(26),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(22),
                      child: Icon(
                        Icons.agriculture,
                        size: 56,
                        color: scheme.onPrimaryContainer,
                      ),
                    ),
                  ),
                  const SizedBox(height: 22),
                  Text(
                    AppConstants.appName,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: scheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Farm work, weather and local support',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 28),
                  SizedBox(
                    width: 96,
                    child: LinearProgressIndicator(
                      minHeight: 4,
                      borderRadius: BorderRadius.circular(99),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
