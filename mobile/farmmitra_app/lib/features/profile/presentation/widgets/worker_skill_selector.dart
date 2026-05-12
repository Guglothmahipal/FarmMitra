import 'package:flutter/material.dart';

class WorkerSkillSelector extends StatelessWidget {
  const WorkerSkillSelector({
    required this.selectedSkills,
    required this.onChanged,
    super.key,
  });

  static const options = [
    'Harvesting',
    'Irrigation',
    'Tractor',
    'Spraying',
    'Dairy',
    'Sowing',
  ];

  final Set<String> selectedSkills;
  final ValueChanged<Set<String>> onChanged;

  @override
  Widget build(BuildContext context) {
    return FormField<Set<String>>(
      initialValue: selectedSkills,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Select at least one skill';
        }
        return null;
      },
      builder: (field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Choose your skills',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: const Color(0xFF182217),
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final skill in options)
                  _SkillChip(
                    label: skill,
                    isSelected: selectedSkills.contains(skill),
                    onTap: () {
                      final updated = {...selectedSkills};
                      if (updated.contains(skill)) {
                        updated.remove(skill);
                      } else {
                        updated.add(skill);
                      }
                      field.didChange(updated);
                      onChanged(updated);
                    },
                  ),
              ],
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 180),
              child: field.hasError
                  ? Padding(
                      key: const ValueKey('skill-error'),
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        field.errorText!,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: const Color(0xFFBA5A4D),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    )
                  : const SizedBox.shrink(key: ValueKey('skill-ok')),
            ),
          ],
        );
      },
    );
  }
}

class _SkillChip extends StatelessWidget {
  const _SkillChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: isSelected ? 1.02 : 1,
      duration: const Duration(milliseconds: 140),
      curve: Curves.easeOut,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(999),
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOutCubic,
            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFF2F7D3C) : Colors.white,
              borderRadius: BorderRadius.circular(999),
              border: Border.all(
                color: isSelected
                    ? const Color(0xFF2F7D3C)
                    : const Color(0xFFD6E1D0),
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: const Color(0xFF2F7D3C).withValues(alpha: 0.16),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ]
                  : null,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 150),
                  child: isSelected
                      ? const Icon(
                          Icons.check_rounded,
                          key: ValueKey('selected'),
                          color: Colors.white,
                          size: 16,
                        )
                      : const Icon(
                          Icons.add_rounded,
                          key: ValueKey('unselected'),
                          color: Color(0xFF71806A),
                          size: 16,
                        ),
                ),
                const SizedBox(width: 5),
                Text(
                  label,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: isSelected ? Colors.white : const Color(0xFF30402D),
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
