import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:hollypalm/_core/base/base_view_model.dart';
import 'package:hollypalm/_core/services/shared/app_service.dart';
import 'package:hollypalm/_core/services/shopify_services.dart';
import 'package:hollypalm/_features/data/response/product/product_model.dart';

final getIt = GetIt.instance;

/// Provider
final homeViewModelProvider = AsyncNotifierProvider<HomeViewModel, HomeState>(HomeViewModel.new);

/// ViewModel
class HomeViewModel extends BaseViewModel<HomeState> {
  final shopifyServices = getIt.get<ShopifyServices>();
  final appService = getIt.get<AppService>();

  @override
  Future<HomeState> build() async {
    return _fetchHomeData();
  }

  Future<HomeState> _fetchHomeData() async {
    final products = await shopifyServices.getProducts().then((value) => value.products);
    final cart = await shopifyServices.createCart().then((value) => value.cartCreate);
    appService.cartId = cart?.cart?.id ?? '';
    return HomeState(products: products);
  }

  /// dışarıdan çağrılabilir (buton vs.)
  Future<void> refresh() async {
    state = const AsyncLoading();
    state = AsyncData(await _fetchHomeData());
  }
}

/// State (ViewState)
class HomeState {
  final Products? products;

  const HomeState({this.products});
}
