import 'package:flutter/material.dart';
import 'package:hollypalm/_core/utils/common/add_to_cart_button_widget.dart';
import 'package:hollypalm/_core/utils/common/text_widget.dart';
import 'package:hollypalm/_core/utils/theme/colors.dart';
import 'package:hollypalm/_core/utils/theme/widgets.dart';
import 'package:hollypalm/_features/data/enums/holly_text_type.dart';
import 'package:hollypalm/_features/data/response/product/product_varyant_response.dart';

enum AddToCartState { idle, loading, success, disabled }

class HollyProductInfoCard extends StatelessWidget {
  const HollyProductInfoCard({super.key, required this.brand, required this.productName, required this.price, required this.description, this.imageUrl, required this.currencyCode, this.variants});

  final String brand;
  final String productName;
  final String price;
  final String description;
  final String? imageUrl;
  final String currencyCode;
  final Variants? variants;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: HollyColor.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: HollyColor.gray200),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // IMAGE
          if (imageUrl != null)
            AspectRatio(
              aspectRatio: 1,
              child: Image.network(
                imageUrl!,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(color: HollyColor.gray100, alignment: Alignment.center, child: const CircularProgressIndicator(strokeWidth: 2));
                },
                errorBuilder: (_, __, ___) => Container(
                  color: HollyColor.gray100,
                  alignment: Alignment.center,
                  child: Icon(Icons.image_not_supported_outlined, color: HollyColor.gray400),
                ),
              ),
            ),

          // CONTENT
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // BRAND
                HollyText(text: brand.toUpperCase(), type: HollyTextType.caption, color: HollyColor.gray600),

                const SizedBox(height: 8),

                // PRODUCT NAME
                HollyText(text: productName, type: HollyTextType.title, color: HollyColor.primary900, maxLines: 2, overflow: TextOverflow.ellipsis),

                const SizedBox(height: 12),

                // PRICE
                Row(
                  children: [
                    HollyText(text: price, type: HollyTextType.price, color: HollyColor.secondary500),
                    HollyText(text: currencyCode, type: HollyTextType.price, color: HollyColor.secondary500),
                  ],
                ),

                const SizedBox(height: 12),

                // DESCRIPTION
                HollyText(text: description, type: HollyTextType.body, color: HollyColor.gray700, maxLines: 3, overflow: TextOverflow.ellipsis),

                if (description.isNotEmpty) const SizedBox(height: 20),

                SizedBox(
                  height: 44,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: variants?.edges?.length ?? 0,
                    itemBuilder: (context, index) {
                      return Builder(
                        builder: (context) {
                          if (variants?.edges?[index].node?.image?.url == null) {
                            return qZeroSizedBox;
                          } else {
                            return AspectRatio(
                              aspectRatio: 1,
                              child: Image.network(
                                variants?.edges?[index].node?.image?.url ?? '',
                                fit: BoxFit.cover,
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Container(color: HollyColor.gray100, alignment: Alignment.center, child: const CircularProgressIndicator(strokeWidth: 2));
                                },
                                errorBuilder: (_, __, ___) => qZeroSizedBox,
                              ),
                            );
                          }
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
