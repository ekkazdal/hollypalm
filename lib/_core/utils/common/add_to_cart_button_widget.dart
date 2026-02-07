import 'package:flutter/material.dart';
import 'package:hollypalm/_core/utils/common/text_widget.dart';
import 'package:hollypalm/_core/utils/theme/colors.dart';
import 'package:hollypalm/_features/data/enums/holly_text_type.dart';
import 'package:hollypalm/_features/presentation/home/view/components/product_card.dart';

class AddToCartButton extends StatelessWidget {
  const AddToCartButton({super.key, required this.state, required this.onPressed});

  final AddToCartState state;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final bool disabled = state == AddToCartState.loading || state == AddToCartState.disabled;

    return SizedBox(
      height: 52,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: disabled ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: _backgroundColor(),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: _content(),
      ),
    );
  }

  Widget _content() {
    if (state == AddToCartState.loading) {
      return const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation<Color>(Colors.white)));
    }

    return HollyText(text: state == AddToCartState.success ? 'Sepete Eklendi ✓' : 'Sepete Ekle', type: HollyTextType.button, color: HollyColor.white);
  }

  Color _backgroundColor() {
    switch (state) {
      case AddToCartState.success:
        return HollyColor.success;
      case AddToCartState.disabled:
        return HollyColor.gray300;
      default:
        return HollyColor.secondary500;
    }
  }
}
