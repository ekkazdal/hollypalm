// ignore_for_file: use_build_context_synchronously, prefer_typing_uninitialized_variables, depend_on_referenced_packages

import 'package:get_it/get_it.dart';
import 'package:hollypalm/_features/data/response/cart/cart_response_model.dart';

final getIt = GetIt.instance;

class AppService {
  AppService();

  String cartId = '';

  CartResponseModel cart = CartResponseModel();
}
