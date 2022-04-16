// You have generated a new plugin project without
// specifying the `--platforms` flag. A plugin project supports no platforms is generated.
// To add platforms, run `flutter create -t plugin --platforms <platforms> .` under the same
// directory. You can also find a detailed instruction on how to add platforms in the `pubspec.yaml` at https://flutter.dev/docs/development/packages-and-plugins/developing-packages#plugin-platforms.

import 'package:flutter/material.dart';

import 'number_captcha_dialog.dart';

class FlutterNumberCaptcha {
  static Future<bool> show(
    context, {
    String titleText = 'Enter correct number',
    String placeholderText = 'Enter Number',
    String checkCaption = 'Check',
  }) async {
    bool? result = await showDialog(
      context: context,
      builder: (context) {
        return NumberCaptchaDialog(
          titleText,
          placeholderText,
          checkCaption,
        );
      },
    );
    if (result == true) {
      return true;
    }
    return false;
  }
}
