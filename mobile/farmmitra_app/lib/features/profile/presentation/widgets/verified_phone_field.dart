import 'package:flutter/material.dart';

class VerifiedPhoneField extends StatelessWidget {
  const VerifiedPhoneField({required this.phoneNumber, super.key});

  final String phoneNumber;

  @override
  Widget build(BuildContext context) {
    final displayPhone = phoneNumber.trim().isEmpty
        ? '+91 verified mobile'
        : '+91 ${phoneNumber.trim()}';

    return Semantics(
      label: 'Verified mobile number $displayPhone',
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: const Color(0xFFEFF3EB),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFD6E1D0)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.phone_android_rounded,
                  color: Color(0xFF5E6D58),
                  size: 19,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Verified mobile',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: const Color(0xFF64705E),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      displayPhone,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: const Color(0xFF182217),
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
                decoration: BoxDecoration(
                  color: const Color(0xFFE2F3D8),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.verified_rounded,
                      color: Color(0xFF2F7D3C),
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Verified',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: const Color(0xFF2F7D3C),
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
