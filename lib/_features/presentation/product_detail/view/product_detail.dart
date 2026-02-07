// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hollypalm/_core/utils/common/cart_fab_widget.dart';
import 'package:hollypalm/_core/utils/common/text_widget.dart';
import 'package:hollypalm/_core/utils/theme/colors.dart';
import 'package:hollypalm/_core/utils/theme/widgets.dart';
import 'package:hollypalm/_features/data/enums/holly_text_type.dart';
import 'package:hollypalm/_features/presentation/product_detail/view_model/product_detail_view_model.dart';

class ProductDetail extends ConsumerStatefulWidget {
  final String productId;
  const ProductDetail({super.key, required this.productId});

  @override
  ConsumerState<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends ConsumerState<ProductDetail> {
  @override
  void initState() {
    super.initState();

    /// Riverpod 3'te initState içinde ref.read() SERBEST
    /// build() otomatik tetiklenir
    Future.microtask(() async {
      await ref.read(productDetailViewModelProvider.notifier);
      await ref.read(productDetailViewModelProvider.notifier).fetchProductDetailData(widget.productId);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final homeState = ref.watch(productDetailViewModelProvider);

    return Scaffold(
      floatingActionButton: CartFabWidget(onPressed: () {}, itemCount: ref.read(productDetailViewModelProvider.notifier).cartList?.cart?.totalQuantity ?? 0),

      appBar: AppBar(
        title: const HollyText(text: 'Ürün Detay', type: HollyTextType.subtitle),
        elevation: 0,
        backgroundColor: HollyColor.background,
      ),

      /// FLOATING FOOTER – SEPETE EKLE
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: HollyColor.background,
            border: Border(top: BorderSide(color: HollyColor.border)),
          ),
          child: SizedBox(
            height: 52,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: HollyColor.secondary,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              onPressed: ref.read(productDetailViewModelProvider.notifier).selectedVariant?.availableForSale == true && ref.read(productDetailViewModelProvider.notifier).selectedVariant?.currentlyNotInStock == false
                  ? () {
                      ref.read(productDetailViewModelProvider.notifier).addLineItems();
                    }
                  : null,
              child: const HollyText(text: 'Sepete Ekle', type: HollyTextType.button, color: Colors.white),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: homeState.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Center(child: HollyText(text: "Hata oluştu: $error")),
          data: (state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 120),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// =======================
                  /// IMAGE SLIDER
                  /// =======================
                  SizedBox(
                    height: 300,
                    child: PageView.builder(
                      controller: ref.read(productDetailViewModelProvider.notifier).pageController,
                      itemCount: state.products?.images?.edges?.length ?? 0,
                      itemBuilder: (_, __) => Container(
                        margin: const EdgeInsets.all(16),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.grey.shade200),
                        child: Image.network(
                          state.products?.images?.edges?[__].node?.url ?? '',
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Container(color: HollyColor.gray100, alignment: Alignment.center, child: const CircularProgressIndicator(strokeWidth: 2));
                          },
                          errorBuilder: (_, __, ___) => qZeroSizedBox,
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// BRAND
                        HollyText(text: state.products?.vendor ?? '', type: HollyTextType.caption, color: HollyColor.textSecondary),

                        const SizedBox(height: 4),

                        /// PRODUCT NAME
                        HollyText(text: state.products?.title ?? '', type: HollyTextType.title, color: HollyColor.textPrimary),

                        const SizedBox(height: 12),

                        /// PRICE
                        HollyText(text: '${ref.read(productDetailViewModelProvider.notifier).selectedVariant?.price!.amount} ${ref.read(productDetailViewModelProvider.notifier).selectedVariant?.price!.currencyCode}', type: HollyTextType.price, color: HollyColor.success),

                        const SizedBox(height: 12),

                        /// SHORT DESCRIPTION
                        HollyText(text: state.products?.productType ?? '', type: HollyTextType.body, color: HollyColor.textSecondary),

                        const SizedBox(height: 24),

                        /// VARIANTS
                        const HollyText(text: 'Varyantlar', type: HollyTextType.subtitle, color: HollyColor.textPrimary),

                        const SizedBox(height: 12),

                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            ...state.products?.variants?.edges?.map((e) {
                                  final variant = e.node!;
                                  final isSelected = variant.id == ref.read(productDetailViewModelProvider.notifier).selectedVariant?.id;
                                  return GestureDetector(
                                    onTap: () {
                                      ref.read(productDetailViewModelProvider.notifier).selectVariant(variant);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(24),
                                        color: isSelected ? HollyColor.primary : HollyColor.surface,
                                        border: Border.all(color: isSelected ? HollyColor.primary : HollyColor.border),
                                      ),
                                      child: HollyText(text: variant.title ?? '', type: HollyTextType.caption, color: isSelected ? Colors.white : HollyColor.textPrimary),
                                    ),
                                  );
                                }) ??
                                [],
                          ],
                        ),

                        const SizedBox(height: 32),

                        /// ACCORDION DESCRIPTION
                        ExpansionTile(
                          collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          title: const HollyText(text: 'Ürün Açıklaması', type: HollyTextType.subtitle, color: HollyColor.textPrimary),
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Builder(
                                builder: (context) {
                                  if (state.products?.descriptionHtml == null) {
                                    return const HollyText(text: 'Açıklama bulunamadı.', type: HollyTextType.body, color: HollyColor.textSecondary);
                                  }
                                  return Html(
                                    data: state.products?.descriptionHtml,
                                    style: {'body': Style(fontSize: FontSize(14), color: HollyColor.textSecondary)},
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
