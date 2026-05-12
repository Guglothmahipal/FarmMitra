import 'package:flutter/material.dart';

class AuthKeyboardSafeBody extends StatelessWidget {
  const AuthKeyboardSafeBody({
    required this.child,
    required this.onBack,
    super.key,
  });

  final Widget child;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Positioned(
            top: 8,
            left: 12,
            child: IconButton.filledTonal(
              onPressed: onBack,
              icon: const Icon(Icons.arrow_back_rounded),
            ),
          ),
          Positioned.fill(
            top: 54,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isKeyboardOpen =
                    MediaQuery.viewInsetsOf(context).bottom > 0;
                final topPadding = isKeyboardOpen ? 8.0 : 16.0;
                final bottomPadding = isKeyboardOpen ? 12.0 : 18.0;
                final verticalPadding = topPadding + bottomPadding;
                final minHeight = (constraints.maxHeight - verticalPadding)
                    .clamp(0.0, double.infinity);

                return AnimatedPadding(
                  duration: const Duration(milliseconds: 220),
                  curve: Curves.easeOutCubic,
                  padding: EdgeInsets.fromLTRB(
                    20,
                    topPadding,
                    20,
                    bottomPadding,
                  ),
                  child: SingleChildScrollView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    physics: const ClampingScrollPhysics(),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minHeight: minHeight),
                      child: Align(
                        alignment: isKeyboardOpen
                            ? Alignment.topCenter
                            : Alignment.center,
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 430),
                          child: child,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
