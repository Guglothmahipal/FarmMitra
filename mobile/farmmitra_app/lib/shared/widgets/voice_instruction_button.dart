import 'package:flutter/material.dart';

class VoiceInstructionButton extends StatelessWidget {
  const VoiceInstructionButton({
    required this.instruction,
    this.compact = false,
    super.key,
  });

  final String instruction;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final label = compact ? 'Hear' : 'Tap to hear instructions';

    return Semantics(
      button: true,
      label: label,
      hint: instruction,
      child: compact
          ? IconButton(
              tooltip: label,
              onPressed: () => _showVoicePlaceholder(context),
              icon: const Icon(Icons.volume_up_outlined),
            )
          : OutlinedButton.icon(
              onPressed: () => _showVoicePlaceholder(context),
              icon: const Icon(Icons.volume_up_outlined),
              label: Text(label),
            ),
    );
  }

  void _showVoicePlaceholder(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Voice ready: $instruction'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
