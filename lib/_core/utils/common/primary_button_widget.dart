import 'package:flutter/material.dart';
import 'package:hollypalm/_core/utils/common/text_widget.dart';
import 'package:hollypalm/_core/utils/theme/colors.dart';
import 'package:hollypalm/_features/data/enums/holly_button_state.dart';
import 'package:hollypalm/_features/data/enums/holly_text_type.dart';

class HollyPrimaryButton extends StatelessWidget {
  const HollyPrimaryButton({super.key, required this.text, required this.onPressed, this.state = HollyButtonState.normal});

  final String text;
  final VoidCallback? onPressed;
  final HollyButtonState state;

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = state == HollyButtonState.disabled || state == HollyButtonState.loading;

    return SizedBox(
      height: 56,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isDisabled ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: _backgroundColor(),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: _content(),
      ),
    );
  }

  Widget _content() {
    if (state == HollyButtonState.loading) {
      return const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2));
    }

    return HollyText(text: state == HollyButtonState.success ? 'Eklendi ✓' : text, type: HollyTextType.button, color: Colors.white);
  }

  Color _backgroundColor() {
    switch (state) {
      case HollyButtonState.success:
        return HollyColor.success;
      case HollyButtonState.disabled:
        return HollyColor.gray300;
      default:
        return HollyColor.secondary500;
    }
  }
}
