import 'package:flutter/material.dart';

import 'dialog_content/message_dialog.dart';

const EdgeInsets _defaultInsetPadding =
    EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0);

class DialogProvider {
  static final DialogProvider shared = DialogProvider();

  Widget _mainDialog(childDialog, {useSmallPadding = false, canBack = true}) {
    return WillPopScope(
      onWillPop: () async {
        return canBack;
      },
      child: Dialog(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.white,
        child: childDialog,
        insetPadding: _defaultInsetPadding,
      ),
    );
  }

  void showMessageDialog({
    required BuildContext context,
    required String message,
    String? title,
    String? buttonTitle,
    VoidCallback? onTap,
  }) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => _mainDialog(
        MessageDialog(
          title: title,
          message: message,
          buttonTitle: buttonTitle,
          onTap: onTap,
        ),
      ),
    );
  }
}
