import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hollypalm/_core/error/api_error.dart';
import 'package:hollypalm/_core/error/api_error_model.dart';
import 'package:hollypalm/_core/network/dio_client.dart';
import 'package:hollypalm/_core/utils/dialogs.dart';
import 'package:hollypalm/_core/utils/keys.dart';

abstract class BaseViewModel<T> extends AsyncNotifier<T> {
  BaseViewModel();

  BaseViewModel.ctx(this.context);

  final dioService = getIt<DioClient>();

  bool disposed = false;
  late BuildContext context;

  setControllerValue(TextEditingController? controller, String? value) {
    try {
      if (value == "null") value = "";
      if (value != null && value.isNotEmpty) {
        controller?.text = value;
      } else {
        controller?.text = "";
      }
    } on Exception {
      rethrow;
    }
  }

  Future<T?> apiCall<T extends Object?>(
    final Future<T> Function() request, {
    final Object? param,
    final ValueChanged<T>? onSuccess,
    final void Function(ApiError, StackTrace)? onError,
    final bool primaryLoading = true,
    final void Function(ApiError)? onPopDialog,
    final bool returnData = false,
    final int retryCount = 0,
  }) async {
    T? responseData;
    int currentRetry = 0;

    do {
      try {
        responseData = await request();

        if (!disposed) {
          onSuccess?.call(responseData!);
          if (returnData) return responseData;
        }
        break;
      } on ApiError catch (e, s) {
        if (!disposed) {
          if (onError != null) {
            onError(e, s);
          } else {
            await handleError(e, onPopDialog: onPopDialog);
          }

          if (currentRetry < retryCount) {
            currentRetry++;
            await Future.delayed(const Duration(seconds: 2)); // Yeniden deneme öncesi bekle
            continue;
          }
        }
        return null;
      } catch (e, s) {
        debugPrint('Beklenmeyen hata: $e\n$s');
        return null;
      }
    } while (currentRetry <= retryCount);

    return responseData;
  }

  Future<void> handleError(final Exception error, {final VoidCallback? onPositiveButtonPressed, final VoidCallback? onNegativeButtonPressed, final void Function(ApiError)? onPopDialog}) async {
    if (error is ApiError) {
      await showDialog(
        useSafeArea: true,
        context: rootNavigatorKey.currentContext!,
        builder: (context) => AppDialogs().apiErrorDialog(
          ErrorResponseModel(
            message: error.message,
            isSuccess: false,
            data: Data(errorMessage: error.message, errorDetails: error.messages),
          ),
        ),
      );
      onPopDialog?.call(error);
    }
  }
}
