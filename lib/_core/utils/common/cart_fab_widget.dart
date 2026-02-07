import 'package:flutter/material.dart';
import 'package:hollypalm/_core/utils/theme/colors.dart';

class CartFabWidget extends StatelessWidget {
  const CartFabWidget({super.key, required this.itemCount, required this.onPressed});

  final int itemCount;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: HollyColor.primary900,
      onPressed: onPressed,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          const Icon(Icons.shopping_bag_outlined, color: Colors.white),

          // BADGE
          if (itemCount > 0) Positioned(top: -8, right: -8, child: _CartBadge(count: itemCount)),
        ],
      ),
    );
  }
}

class _CartBadge extends StatelessWidget {
  const _CartBadge({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(color: HollyColor.secondary500, borderRadius: BorderRadius.circular(12)),
      constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
      child: Center(
        child: Text(
          count > 99 ? '99+' : count.toString(),
          style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
