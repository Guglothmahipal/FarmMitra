import 'package:flutter/material.dart';

class ProfileTagWrap extends StatelessWidget {
  const ProfileTagWrap({required this.items, super.key});

  final List<String> items;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return Text(
        'Not added yet',
        style: Theme.of(context).textTheme.bodyMedium,
      );
    }

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final item in items)
          Chip(label: Text(item), visualDensity: VisualDensity.compact),
      ],
    );
  }
}
