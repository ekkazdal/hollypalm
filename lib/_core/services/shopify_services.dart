// ignore_for_file: use_build_context_synchronously, prefer_typing_uninitialized_variables, depend_on_referenced_packages

import 'package:get_it/get_it.dart';
import 'package:hollypalm/_core/network/dio_client.dart';
import 'package:hollypalm/_core/services/shopify_graphql_service.dart';
import 'package:hollypalm/_features/data/response/cart/cart_create_response_model.dart';
import 'package:hollypalm/_features/data/response/cart/cart_detail_response_model.dart';
import 'package:hollypalm/_features/data/response/cart/cart_response_model.dart';
import 'package:hollypalm/_features/data/response/product/product_response_model.dart';
import 'package:hollypalm/_features/data/response/product_detail/product_detail_response_model.dart';

final getIt = GetIt.instance;

class ShopifyServices {
  var dioClient = getIt.get<DioClient>();
  var shopifyGraphQLService = getIt.get<ShopifyGraphQLService>();

  Future<ProductResponseModel> getProducts() async {
    String getProductsQuery = r'''
query Products {
    products(first: 15) {
        edges {
            node {
                id
                title
                vendor
                description
                descriptionHtml
                priceRange {
                    minVariantPrice {
                        amount
                        currencyCode
                    }
                    maxVariantPrice {
                        amount
                        currencyCode
                    }
                }
                featuredImage {
                    altText
                    height
                    id
                    originalSrc
                    src
                    thumbhash
                    transformedSrc
                    url
                    width
                }
                images(first: 5) {
                    edges {
                        node {
                            altText
                            height
                            id
                            originalSrc
                            src
                            thumbhash
                            transformedSrc
                            url
                            width
                        }
                    }
                }
                variants(first: 15) {
                    edges {
                        node {
                            id
                            barcode
                            image {
                                altText
                                height
                                id
                                originalSrc
                                src
                                thumbhash
                                transformedSrc
                                url
                                width
                            }
                            price {
                                amount
                                currencyCode
                            }
                            product {
                                availableForSale
                                createdAt
                                description
                                descriptionHtml
                                encodedVariantAvailability
                                encodedVariantExistence
                                handle
                                id
                                isGiftCard
                                onlineStoreUrl
                                productType
                                publishedAt
                                requiresSellingPlan
                                title
                                totalInventory
                                trackingParameters
                                updatedAt
                                vendor
                            }
                        }
                    }
                }
            }
        }
    }
}
''';
    final data = await shopifyGraphQLService.query(query: getProductsQuery);

    return ProductResponseModel.fromJson(data);
  }

  Future<CreateCardResponseModel> createCart() async {
    String getCreateCartMutation = r'''
mutation CartCreate {
    cartCreate {
        cart {
            checkoutUrl
            createdAt
            id
            note
            totalQuantity
            updatedAt
        }
    }
}
''';
    final data = await shopifyGraphQLService.mutation(mutation: getCreateCartMutation);

    return CreateCardResponseModel.fromJson(data);
  }

  Future<CartResponseModel> cartList(String cartId) async {
    const String getProductsQuery = r'''
query Cart($cartId: ID!) {
  cart(id: $cartId) {
    checkoutUrl
    createdAt
    id
    note
    totalQuantity
    updatedAt
  }
}
''';
    final data = await shopifyGraphQLService.query(query: getProductsQuery, variables: {'cartId': cartId});

    return CartResponseModel.fromJson(data);
  }

  Future<ProductDetailResponseModel> productDetail(String productId) async {
    const String getProductsQuery = r'''
query Product($id: ID!) {
    product(id: $id) {
        availableForSale
        createdAt
        description
        descriptionHtml
        encodedVariantAvailability
        encodedVariantExistence
        handle
        id
        isGiftCard
        onlineStoreUrl
        productType
        publishedAt
        requiresSellingPlan
        tags
        title
        totalInventory
        trackingParameters
        updatedAt
        vendor
        images(first: 5) {
            edges {
                node {
                    altText
                    height
                    id
                    originalSrc
                    src
                    thumbhash
                    transformedSrc
                    url
                    width
                }
            }
        }
        variants(first: 5) {
            edges {
                node {
                    availableForSale
                    barcode
                    currentlyNotInStock
                    id
                    quantityAvailable
                    title
                    weight
                    weightUnit
                    price {
                        amount
                        currencyCode
                    }
                    image {
                        altText
                        height
                        id
                        originalSrc
                        src
                        thumbhash
                        transformedSrc
                        url
                        width
                    }
                }
            }
        }
    }
}
''';
    final data = await shopifyGraphQLService.query(query: getProductsQuery, variables: {'id': productId});

    return ProductDetailResponseModel.fromJson(data);
  }

  Future<CartDetailResponseModel> addLineItems(String cartId, String variantId, int quantity) async {
    const String getProductsQuery = r'''
mutation CartLinesAddExample($cartId: ID!, $lines: [CartLineInput!]!) {
  cartLinesAdd(cartId: $cartId, lines: $lines) {
    cart {
      id
      totalQuantity
      lines(first: 10) {
        edges {
          node {
            id
            quantity
            merchandise {
              ... on ProductVariant {
                id
                title
                sku
                price {
                  amount
                  currencyCode
                }
              }
            }
          }
        }
      }
    }
    userErrors {
      field
      message
      code
    }
    warnings {
      code
      message
    }
  }
}
''';
    final data = await shopifyGraphQLService.query(
      query: getProductsQuery,
      variables: {
        'cartId': cartId,
        'lines': [
          {
            "merchandiseId": variantId,
            "quantity": quantity,
            "attributes": {"key": "test", "value": "test"},
          },
        ],
      },
    );

    return CartDetailResponseModel.fromJson(data);
  }
}
