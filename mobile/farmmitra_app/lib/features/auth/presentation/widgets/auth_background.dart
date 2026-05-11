import 'dart:ui';

import 'package:flutter/material.dart';

class AuthBackground extends StatelessWidget {
  const AuthBackground({required this.child, super.key});

  final Widget child;

  static const backgroundAsset =
      'assets/branding/backgrounds/khetrojgar_splash_background.jpg';

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        ImageFiltered(
          imageFilter: ImageFilter.blur(sigmaX: 1.6, sigmaY: 1.6),
          child: Transform.scale(
            scale: 1.015,
            child: Image.asset(
              backgroundAsset,
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
              colors: [Color(0x26000000), Color(0x6107190D), Color(0xCC06140A)],
            ),
          ),
        ),
        child,
      ],
    );
  }
}
