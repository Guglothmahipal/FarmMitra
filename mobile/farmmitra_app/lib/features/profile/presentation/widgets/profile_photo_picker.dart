import 'package:farmmitra_app/core/localization/locale_extensions.dart';
import 'package:flutter/material.dart';

class ProfilePhotoPicker extends StatelessWidget {
  const ProfilePhotoPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFF9FCF5),
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(context.l10n.profilePhotoComingSoon)),
          );
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: const Color(0xFFBFD2B9),
              style: BorderStyle.solid,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFE7F4DF),
                ),
                child: const Icon(
                  Icons.add_a_photo_outlined,
                  color: Color(0xFF2F7D3C),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.l10n.profilePhotoOptional,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: const Color(0xFF172016),
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      context.l10n.profilePhotoHelp,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: const Color(0xFF66735F),
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.upload_rounded, color: Color(0xFF66735F)),
            ],
          ),
        ),
      ),
    );
  }
}
