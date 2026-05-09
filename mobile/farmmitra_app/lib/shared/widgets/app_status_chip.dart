import 'package:flutter/material.dart';

class AppStatusChip extends StatelessWidget {
  const AppStatusChip({
    required this.label,
    required this.icon,
    this.color,
    super.key,
  });

  final String label;
  final IconData icon;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final foreground = color ?? Theme.of(context).colorScheme.primary;

    return Chip(
      avatar: Icon(icon, size: 18, color: foreground),
      label: Text(label),
      visualDensity: VisualDensity.compact,
    );
  }
}
