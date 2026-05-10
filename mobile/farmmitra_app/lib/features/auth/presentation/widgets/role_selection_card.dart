import 'package:flutter/material.dart';

class RoleSelectionCard extends StatefulWidget {
  const RoleSelectionCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.isSelected,
    required this.onTap,
    required this.gradient,
    super.key,
  });

  final String title;
  final String description;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;
  final List<Color> gradient;

  @override
  State<RoleSelectionCard> createState() => _RoleSelectionCardState();
}

class _RoleSelectionCardState extends State<RoleSelectionCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return AnimatedScale(
      scale: _isPressed
          ? 0.98
          : widget.isSelected
          ? 1.015
          : 1,
      duration: const Duration(milliseconds: 140),
      curve: Curves.easeOut,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 240),
        curve: Curves.easeOutCubic,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(26),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: widget.isSelected
                ? widget.gradient
                : const [Colors.white, Color(0xFFF7FBF1)],
          ),
          border: Border.all(
            color: widget.isSelected
                ? widget.gradient.first.withValues(alpha: 0.75)
                : const Color(0xFFE1E9DA),
            width: widget.isSelected ? 1.6 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: widget.isSelected
                  ? widget.gradient.first.withValues(alpha: 0.28)
                  : Colors.black.withValues(alpha: 0.07),
              offset: const Offset(0, 14),
              blurRadius: widget.isSelected ? 28 : 20,
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(26),
            onTap: widget.onTap,
            onHighlightChanged: (value) => setState(() => _isPressed = value),
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Row(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 240),
                    width: 58,
                    height: 58,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: widget.isSelected
                          ? Colors.white.withValues(alpha: 0.92)
                          : widget.gradient.first.withValues(alpha: 0.12),
                      boxShadow: widget.isSelected
                          ? [
                              BoxShadow(
                                color: Colors.white.withValues(alpha: 0.22),
                                blurRadius: 18,
                              ),
                            ]
                          : null,
                    ),
                    child: Icon(
                      widget.icon,
                      color: widget.isSelected
                          ? widget.gradient.first
                          : scheme.primary,
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(
                                color: widget.isSelected
                                    ? Colors.white
                                    : const Color(0xFF172016),
                                fontWeight: FontWeight.w900,
                                letterSpacing: 0,
                              ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          widget.description,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                height: 1.35,
                                color: widget.isSelected
                                    ? Colors.white.withValues(alpha: 0.9)
                                    : const Color(0xFF667061),
                              ),
                        ),
                      ],
                    ),
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 220),
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: widget.isSelected
                          ? Colors.white
                          : Colors.transparent,
                      border: Border.all(
                        color: widget.isSelected
                            ? Colors.white
                            : const Color(0xFFC8D4C1),
                      ),
                    ),
                    child: widget.isSelected
                        ? Icon(
                            Icons.check_rounded,
                            size: 18,
                            color: widget.gradient.first,
                          )
                        : null,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
