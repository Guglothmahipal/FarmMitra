import 'dart:ui';

import 'package:farmmitra_app/core/constants/app_constants.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  static const _backgroundAsset =
      'assets/branding/backgrounds/khetrojgar_splash_background.jpg';
  static const _logoAsset = 'assets/branding/splash/khetrojgar_splash_logo.png';

  @override
  Widget build(BuildContext context) {
    final shortestSide = MediaQuery.sizeOf(context).shortestSide;
    final logoSize = (shortestSide * 0.48).clamp(156.0, 220.0).toDouble();

    return Scaffold(
      backgroundColor: const Color(0xFF07180E),
      body: Stack(
        fit: StackFit.expand,
        children: [
          const _SplashBackground(assetPath: _backgroundAsset),
          Positioned.fill(
            child: IgnorePointer(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment.center,
                    radius: 0.62,
                    colors: [
                      const Color(0xFFAAD66F).withValues(alpha: 0.12),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0, end: 1),
              duration: const Duration(milliseconds: 850),
              curve: Curves.easeOutCubic,
              builder: (context, value, child) {
                return Opacity(
                  opacity: value,
                  child: Transform.translate(
                    offset: Offset(0, 16 * (1 - value)),
                    child: Transform.scale(
                      scale: 0.95 + (0.05 * value),
                      child: child,
                    ),
                  ),
                );
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _SplashLogo(assetPath: _logoAsset, size: logoSize),
                  const SizedBox(height: 18),
                  Text(
                    AppConstants.appName,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.2,
                      shadows: [
                        Shadow(
                          color: Colors.black.withValues(alpha: 0.45),
                          blurRadius: 14,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 28),
                  const _SplashLoader(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SplashBackground extends StatelessWidget {
  const _SplashBackground({required this.assetPath});

  final String assetPath;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        ImageFiltered(
          imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Transform.scale(
            scale: 1.06,
            child: Image.asset(
              assetPath,
              fit: BoxFit.cover,
              cacheWidth: 900,
              filterQuality: FilterQuality.low,
            ),
          ),
        ),
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xCC0B2817), Color(0x99040B06), Color(0xE6000000)],
            ),
          ),
        ),
      ],
    );
  }
}

class _SplashLogo extends StatelessWidget {
  const _SplashLogo({required this.assetPath, required this.size});

  final String assetPath;
  final double size;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFAAD66F).withValues(alpha: 0.22),
              blurRadius: 42,
              spreadRadius: 4,
            ),
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.38),
              blurRadius: 30,
              offset: const Offset(0, 16),
            ),
          ],
        ),
        child: SizedBox.square(
          dimension: size,
          child: Image.asset(
            assetPath,
            fit: BoxFit.contain,
            filterQuality: FilterQuality.high,
            gaplessPlayback: true,
          ),
        ),
      ),
    );
  }
}

class _SplashLoader extends StatelessWidget {
  const _SplashLoader();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black.withValues(alpha: 0.18),
        border: Border.all(color: Colors.white.withValues(alpha: 0.16)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: SizedBox.square(
          dimension: 26,
          child: CircularProgressIndicator(
            strokeWidth: 2.4,
            strokeCap: StrokeCap.round,
            color: Colors.white.withValues(alpha: 0.88),
            backgroundColor: Colors.white.withValues(alpha: 0.16),
          ),
        ),
      ),
    );
  }
}
