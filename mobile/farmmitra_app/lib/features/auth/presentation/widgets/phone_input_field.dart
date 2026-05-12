import 'package:farmmitra_app/core/localization/locale_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhoneInputField extends StatefulWidget {
  const PhoneInputField({
    required this.controller,
    this.autofocus = false,
    super.key,
  });

  final TextEditingController controller;
  final bool autofocus;

  @override
  State<PhoneInputField> createState() => _PhoneInputFieldState();
}

class _PhoneInputFieldState extends State<PhoneInputField> {
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode()..addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasFocus = _focusNode.hasFocus;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOutCubic,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.9),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: hasFocus
                    ? const Color(0xFF4F9360)
                    : const Color(0xFFA6C7A6),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(
                    0xFF2F7D3C,
                  ).withValues(alpha: hasFocus ? 0.10 : 0.05),
                  blurRadius: hasFocus ? 12 : 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: TextField(
              controller: widget.controller,
              focusNode: _focusNode,
              autofocus: widget.autofocus,
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.done,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: const Color(0xFF152015),
                fontWeight: FontWeight.w700,
              ),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10),
              ],
              decoration: InputDecoration(
                hintText: context.l10n.loginMobileHint,
                counterText: '',
                border: InputBorder.none,
                hintStyle: TextStyle(
                  color: Colors.black.withValues(alpha: 0.34),
                  fontWeight: FontWeight.w500,
                ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 13, right: 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.phone_android_rounded, size: 20),
                      const SizedBox(width: 8),
                      const _IndiaFlagMark(),
                      const SizedBox(width: 7),
                      Text(
                        '+91',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        width: 1,
                        height: 22,
                        color: const Color(0xFFD5DDD0),
                      ),
                    ],
                  ),
                ),
                prefixIconConstraints: const BoxConstraints(minWidth: 112),
                contentPadding: const EdgeInsets.fromLTRB(0, 14, 16, 14),
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 18,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            padding: const EdgeInsets.symmetric(horizontal: 7),
            decoration: BoxDecoration(
              color: const Color(0xFFF9FCF5),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              context.l10n.loginMobileLabel,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: hasFocus
                    ? const Color(0xFF2F7D3C)
                    : const Color(0xFF4D7C54),
                fontWeight: FontWeight.w700,
                height: 1,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _IndiaFlagMark extends StatelessWidget {
  const _IndiaFlagMark();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(2),
      child: SizedBox(
        width: 22,
        height: 14,
        child: Column(
          children: [
            Expanded(child: Container(color: const Color(0xFFFF9933))),
            Expanded(
              child: ColoredBox(
                color: Colors.white,
                child: Center(
                  child: Container(
                    width: 4,
                    height: 4,
                    decoration: const BoxDecoration(
                      color: Color(0xFF000080),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(child: Container(color: const Color(0xFF138808))),
          ],
        ),
      ),
    );
  }
}
