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

    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOutCubic,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: hasFocus ? const Color(0xFF3B8350) : const Color(0xFF8AB793),
          width: hasFocus ? 1.2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(
              0xFF2F7D3C,
            ).withValues(alpha: hasFocus ? 0.12 : 0.07),
            blurRadius: hasFocus ? 15 : 10,
            offset: const Offset(0, 5),
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
          labelText: 'Mobile number',
          hintText: 'Enter Mobile Number',
          counterText: '',
          border: InputBorder.none,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelStyle: const TextStyle(
            color: Color(0xFF2F7D3C),
            fontWeight: FontWeight.w700,
            fontSize: 12,
          ),
          hintStyle: TextStyle(
            color: Colors.black.withValues(alpha: 0.34),
            fontWeight: FontWeight.w500,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 13, right: 9),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.phone_android_rounded, size: 20),
                const SizedBox(width: 9),
                const _IndiaFlagMark(),
                const SizedBox(width: 6),
                Text(
                  '+91',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(width: 9),
                Container(width: 1, height: 24, color: const Color(0xFFD5DDD0)),
              ],
            ),
          ),
          prefixIconConstraints: const BoxConstraints(minWidth: 112),
          contentPadding: const EdgeInsets.fromLTRB(0, 15, 16, 15),
        ),
      ),
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
