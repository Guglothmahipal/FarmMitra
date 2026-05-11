import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpInputWidget extends StatefulWidget {
  const OtpInputWidget({required this.onChanged, this.onCompleted, super.key});

  final ValueChanged<String> onChanged;
  final ValueChanged<String>? onCompleted;

  @override
  State<OtpInputWidget> createState() => _OtpInputWidgetState();
}

class _OtpInputWidgetState extends State<OtpInputWidget> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  Timer? _cursorTimer;
  bool _showCursor = true;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController()..addListener(_handleTextChanged);
    _focusNode = FocusNode()..addListener(_handleFocusChanged);
  }

  @override
  void dispose() {
    _cursorTimer?.cancel();
    _focusNode.dispose();
    _controller
      ..removeListener(_handleTextChanged)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final value = _controller.text;
    final activeIndex = value.length.clamp(0, 5);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _focusNode.requestFocus,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            children: List.generate(6, (index) {
              final digit = index < value.length ? value[index] : '';
              final isActive = _focusNode.hasFocus && index == activeIndex;

              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: index == 5 ? 0 : 8),
                  child: _OtpBox(
                    digit: digit,
                    isActive: isActive,
                    showCursor: isActive && digit.isEmpty && _showCursor,
                    onTap: _focusNode.requestFocus,
                  ),
                ),
              );
            }),
          ),
          SizedBox(
            width: 1,
            height: 1,
            child: Opacity(
              opacity: 0,
              child: TextField(
                controller: _controller,
                focusNode: _focusNode,
                autofocus: true,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                maxLength: 6,
                enableInteractiveSelection: false,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(6),
                ],
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  counterText: '',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleFocusChanged() {
    if (_focusNode.hasFocus) {
      _startCursorTimer();
    } else {
      _cursorTimer?.cancel();
      _showCursor = false;
    }

    if (mounted) {
      setState(() {});
    }
  }

  void _handleTextChanged() {
    final sanitized = _controller.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (sanitized != _controller.text) {
      _controller.value = TextEditingValue(
        text: sanitized,
        selection: TextSelection.collapsed(offset: sanitized.length),
      );
      return;
    }

    widget.onChanged(sanitized);
    if (sanitized.length == 6) {
      _focusNode.unfocus();
      widget.onCompleted?.call(sanitized);
    }

    if (mounted) {
      setState(() => _showCursor = true);
    }
  }

  void _startCursorTimer() {
    _cursorTimer?.cancel();
    _showCursor = true;
    _cursorTimer = Timer.periodic(const Duration(milliseconds: 560), (_) {
      if (!mounted || !_focusNode.hasFocus) {
        return;
      }

      setState(() => _showCursor = !_showCursor);
    });
  }
}

class _OtpBox extends StatelessWidget {
  const _OtpBox({
    required this.digit,
    required this.isActive,
    required this.showCursor,
    required this.onTap,
  });

  final String digit;
  final bool isActive;
  final bool showCursor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 170),
      curve: Curves.easeOutCubic,
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.94),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isActive ? const Color(0xFF3F8752) : const Color(0xFFDADFDC),
          width: isActive ? 1.35 : 1,
        ),
        boxShadow: [
          if (isActive)
            BoxShadow(
              color: const Color(0xFF2F7D3C).withValues(alpha: 0.045),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: onTap,
          child: Center(
            child: digit.isNotEmpty
                ? Text(
                    digit,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: const Color(0xFF121B12),
                      fontWeight: FontWeight.w800,
                      height: 1,
                    ),
                  )
                : AnimatedOpacity(
                    opacity: showCursor ? 1 : 0,
                    duration: const Duration(milliseconds: 90),
                    child: Container(
                      width: 1.4,
                      height: 20,
                      decoration: BoxDecoration(
                        color: const Color(0xFF2F7D3C),
                        borderRadius: BorderRadius.circular(99),
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
