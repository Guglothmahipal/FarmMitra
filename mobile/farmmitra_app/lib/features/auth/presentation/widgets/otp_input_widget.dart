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
  late final List<TextEditingController> _controllers;
  late final List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(6, (_) => TextEditingController());
    _focusNodes = List.generate(6, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    for (final node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(6, (index) {
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: index == 5 ? 0 : 7),
            child: AnimatedBuilder(
              animation: _focusNodes[index],
              builder: (context, _) {
                final hasFocus = _focusNodes[index].hasFocus;

                return AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.92),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: hasFocus
                          ? const Color(0xFF3B8350)
                          : const Color(0xFFD8E0D2),
                      width: hasFocus ? 1.4 : 1,
                    ),
                    boxShadow: [
                      if (hasFocus)
                        BoxShadow(
                          color: const Color(
                            0xFF2F7D3C,
                          ).withValues(alpha: 0.10),
                          blurRadius: 12,
                          offset: const Offset(0, 5),
                        ),
                    ],
                  ),
                  child: TextField(
                    controller: _controllers[index],
                    focusNode: _focusNodes[index],
                    autofocus: index == 0,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    textInputAction: index == 5
                        ? TextInputAction.done
                        : TextInputAction.next,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: const Color(0xFF121B12),
                      fontWeight: FontWeight.w900,
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(1),
                    ],
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      counterText: '',
                    ),
                    onChanged: (value) => _handleChanged(index, value),
                    onTap: () =>
                        _controllers[index].selection = TextSelection.collapsed(
                          offset: _controllers[index].text.length,
                        ),
                  ),
                );
              },
            ),
          ),
        );
      }),
    );
  }

  void _handleChanged(int index, String value) {
    if (value.isNotEmpty && index < _focusNodes.length - 1) {
      _focusNodes[index + 1].requestFocus();
    }

    if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }

    final otp = _controllers.map((controller) => controller.text).join();
    widget.onChanged(otp);
    if (otp.length == 6) {
      _focusNodes.last.unfocus();
      widget.onCompleted?.call(otp);
    }
  }
}
