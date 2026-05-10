import 'package:flutter/material.dart';

class FarmerFilterChip extends StatelessWidget {
  const FarmerFilterChip({
    required this.label,
    this.icon,
    this.selected = false,
    super.key,
  });

  final String label;
  final IconData? icon;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      avatar: icon == null ? null : Icon(icon, size: 16),
      label: Text(label),
      selected: selected,
      onSelected: (_) {},
      visualDensity: VisualDensity.compact,
    );
  }
}
