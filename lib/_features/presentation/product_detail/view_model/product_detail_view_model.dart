import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:hollypalm/_core/base/base_view_model.dart';
import 'package:hollypalm/_core/services/shared/app_service.dart';
import 'package:hollypalm/_core/services/shopify_services.dart';
import 'package:hollypalm/_features/data/response/cart/cart_create_response_model.dart';
import 'package:hollypalm/_features/data/response/cart/cart_detail_response_model.dart';
import 'package:hollypalm/_features/data/response/cart/cart_response_model.dart';
import 'package:hollypalm/_features/data/response/product_detail/product_detail_response_model.dart';

final getIt = GetIt.instance;

/// Provider
final productDetailViewModelProvider = AsyncNotifierProvider<ProductDetailViewModel, ProductDetailState>(ProductDetailViewModel.new);

/// ViewModel
class ProductDetailViewModel extends BaseViewModel<ProductDetailState> {
  final shopifyServices = getIt.get<ShopifyServices>();
  final appService = getIt.get<AppService>();

  PageController pageController = PageController();

  Node? selectedVariant;
  CartDetailResponseModel? cartDetailResponseModel;
  CartResponseModel? cartList;

  @override
  Future<ProductDetailState> build() async {
    return _fetchHomeData();
  }

  Future<ProductDetailState> _fetchHomeData() async {
    return ProductDetailState();
  }

  Future<void> fetchProductDetailData(String productId) async {
    state = const AsyncLoading();
    final homeData = await _fetchHomeData();
    final products = await shopifyServices.productDetail(productId).then((value) => value.product);
    selectedVariant = products?.variants!.edges!.first.node;
    state = AsyncData(ProductDetailState(cart: homeData.cart, products: products, selectedVariant: selectedVariant));
  }

  /// dışarıdan çağrılabilir (buton vs.)
  Future<void> refresh() async {
    state = const AsyncLoading();
    state = AsyncData(await _fetchHomeData());
  }

  void selectVariant(Node variant) {
    selectedVariant = variant;
    state = AsyncData(ProductDetailState(products: state.value?.products, selectedVariant: selectedVariant));
  }

  Future<void> addLineItems() async {
    cartDetailResponseModel = await shopifyServices.addLineItems(appService.cartId, selectedVariant!.id!, 1).then((value) => value);
    cartList = await shopifyServices.cartList(appService.cartId!).then((value) => value);
    state = AsyncData(ProductDetailState(cart: state.value!.cart, products: state.value?.products, selectedVariant: selectedVariant));
  }
}

/// State (ViewState)
class ProductDetailState {
  final Product? products;
  final Node? selectedVariant;
  final CartCreate? cart;

  const ProductDetailState({this.products, this.selectedVariant, this.cart});
}
