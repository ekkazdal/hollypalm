// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hollypalm/_features/presentation/home/view/components/product_card.dart';
import 'package:hollypalm/_features/presentation/home/view_model/home_view_model.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();

    /// Riverpod 3'te initState içinde ref.read() SERBEST
    /// build() otomatik tetiklenir
    Future.microtask(() {
      ref.read(homeViewModelProvider.notifier);
    });
  }

  @override
  Widget build(BuildContext context) {
    final homeState = ref.watch(homeViewModelProvider);

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: homeState.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) => Center(
              child: Text("Hata oluştu: $error", style: const TextStyle(color: Colors.red)),
            ),
            data: (state) => Padding(
              padding: const EdgeInsets.all(16),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: state.products?.edges?.length ?? 0,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: InkWell(
                      onTap: () {
                        context.push('/product-detail', extra: state.products?.edges?[index].node?.id);
                      },
                      child: HollyProductInfoCard(
                        brand: state.products?.edges?[index].node?.vendor ?? '',
                        productName: state.products?.edges?[index].node?.title ?? '',
                        price: state.products?.edges?[index].node?.priceRange?.minVariantPrice?.amount ?? '',
                        description: state.products?.edges?[index].node?.description ?? '',
                        imageUrl: state.products?.edges?[index].node?.featuredImage?.src,
                        currencyCode: state.products?.edges?[index].node?.priceRange?.minVariantPrice?.currencyCode ?? '',
                        variants: state.products?.edges?[index].node?.variants,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
