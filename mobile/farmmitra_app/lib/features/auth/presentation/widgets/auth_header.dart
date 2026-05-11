import 'package:flutter/material.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({
    required this.title,
    required this.subtitle,
    this.icon,
    super.key,
  });

  final String title;
  final String subtitle;
  final IconData? icon;

  static const logoAsset = 'assets/branding/logo/khetrojgar_logo_mark.png';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF2F7D3C).withValues(alpha: 0.16),
                blurRadius: 24,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: SizedBox.square(
            dimension: icon == null ? 72 : 66,
            child: icon == null
                ? Image.asset(
                    logoAsset,
                    fit: BoxFit.contain,
                    filterQuality: FilterQuality.high,
                    cacheWidth: 220,
                  )
                : CircleAvatar(
                    backgroundColor: const Color(0xFFE6F6DD),
                    foregroundColor: const Color(0xFF2F7D3C),
                    child: Icon(icon, size: 30),
                  ),
          ),
        ),
        const SizedBox(height: 14),
        Text(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: const Color(0xFF121B12),
            fontWeight: FontWeight.w800,
            height: 1.14,
            letterSpacing: 0,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: const Color(0xFF63705D),
            height: 1.32,
          ),
        ),
      ],
    );
  }
}
