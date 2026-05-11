import 'package:flutter/material.dart';

class LocationActionButton extends StatelessWidget {
  const LocationActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFEAF5E2),
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Location capture will be added in the next phase.',
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 18,
                backgroundColor: Colors.white,
                foregroundColor: Color(0xFF2F7D3C),
                child: Icon(Icons.my_location_rounded, size: 19),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Use current location',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w900,
                        color: const Color(0xFF172016),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Prepare GPS for nearby matching',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: const Color(0xFF66735F),
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded, color: Color(0xFF66735F)),
            ],
          ),
        ),
      ),
    );
  }
}
