import 'package:farmmitra_app/core/localization/locale_extensions.dart';
import 'package:flutter/material.dart';

class GoogleAuthButton extends StatefulWidget {
  const GoogleAuthButton({
    required this.onPressed,
    this.isLoading = false,
    super.key,
  });

  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  State<GoogleAuthButton> createState() => _GoogleAuthButtonState();
}

class _GoogleAuthButtonState extends State<GoogleAuthButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final isEnabled = widget.onPressed != null && !widget.isLoading;

    return AnimatedScale(
      scale: _isPressed ? 0.97 : 1,
      duration: const Duration(milliseconds: 120),
      curve: Curves.easeOut,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(999),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF242424), Color(0xFF030303)],
          ),
          border: Border.all(color: const Color(0xFF343434)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.26),
              offset: const Offset(0, 10),
              blurRadius: 18,
            ),
            BoxShadow(
              color: Colors.white.withValues(alpha: 0.10),
              offset: const Offset(0, -1),
              blurRadius: 6,
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(999),
            onTap: isEnabled ? widget.onPressed : null,
            onHighlightChanged: (value) => setState(() => _isPressed = value),
            child: Container(
              height: 54,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(999),
                gradient: RadialGradient(
                  center: Alignment.topCenter,
                  radius: 1.5,
                  colors: [
                    Colors.white.withValues(alpha: 0.2),
                    Colors.transparent,
                  ],
                ),
              ),
              child: AnimatedOpacity(
                opacity: widget.onPressed == null && !widget.isLoading
                    ? 0.58
                    : 1,
                duration: const Duration(milliseconds: 180),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 160),
                  switchInCurve: Curves.easeOutCubic,
                  switchOutCurve: Curves.easeInCubic,
                  child: Row(
                    key: ValueKey(widget.isLoading),
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.isLoading) ...[
                        const SizedBox(
                          width: 15,
                          height: 15,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 10),
                      ] else ...[
                        const _GoogleMark(),
                        const SizedBox(width: 12),
                      ],
                      Text(
                        context.l10n.loginGoogle,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _GoogleMark extends StatelessWidget {
  const _GoogleMark();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size.square(22),
      painter: _GoogleMarkPainter(),
    );
  }
}

class _GoogleMarkPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = size.width * 0.18;
    final arcRect = (Offset.zero & size).deflate(strokeWidth / 2);

    Paint segment(Color color) => Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas
      ..drawArc(arcRect, -0.10, 1.20, false, segment(const Color(0xFF4285F4)))
      ..drawArc(arcRect, 1.15, 1.22, false, segment(const Color(0xFF34A853)))
      ..drawArc(arcRect, 2.42, 1.05, false, segment(const Color(0xFFFBBC05)))
      ..drawArc(arcRect, 3.46, 1.35, false, segment(const Color(0xFFEA4335)))
      ..drawLine(
        Offset(size.width * 0.54, size.height * 0.5),
        Offset(size.width * 0.92, size.height * 0.5),
        segment(const Color(0xFF4285F4))..strokeCap = StrokeCap.square,
      );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
