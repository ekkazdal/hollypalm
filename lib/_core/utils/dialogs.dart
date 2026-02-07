import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hollypalm/_core/error/api_error_model.dart';
import 'package:hollypalm/_core/utils/common/text_widget.dart';
import 'package:hollypalm/_core/utils/keys.dart';
import 'package:hollypalm/_core/utils/theme/colors.dart';
import 'package:hollypalm/_core/utils/theme/screen_sizes.dart';
import 'package:hollypalm/_core/utils/theme/widgets.dart';
import 'package:hollypalm/_features/data/enums/holly_text_type.dart';

class AppDialogs {
  Dialog apiErrorDialog(ErrorResponseModel desc) {
    log(desc.errorMessage.toString());

    desc.dataMessages.removeAt(0);
    return Dialog(
      insetPadding: const EdgeInsets.all(30),
      backgroundColor: Colors.white,
      shape: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: HollyText(text: 'text.error'.tr(), type: HollyTextType.title, color: Colors.black),
              ),
              qSizedBoxH16,
              SizedBox(child: HollyText(text: desc.errorMessage ?? '')),
              qSizedBoxH16,
              SizedBox(
                height: ScreenSize.widthFactor * 10 * desc.dataMessages.length,
                width: ScreenSize.widthFactor * 100,
                child: ListView.builder(
                  itemCount: desc.dataMessages.length,
                  itemBuilder: (context, index) {
                    log(desc.dataMessages[index].toString());
                    return HollyText(text: ' - ${desc.dataMessages[index]}');
                  },
                ),
              ),
              SizedBox(
                width: ScreenSize.widthFactor * 100,
                child: ElevatedButton(
                  style: ButtonStyle(backgroundColor: WidgetStateProperty.all(HollyColor.secondary500)),
                  onPressed: () {
                    Navigator.pop(rootNavigatorKey.currentContext!);
                  },
                  child: HollyText(text: 'text.close'.tr(), type: HollyTextType.button, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
