import 'package:flutter/material.dart';
import 'package:stack_overflow_app/helper/nav_observer.dart';
import 'package:stack_overflow_app/ui/widget/dialog_widget.dart';

/// Function to show an alert dialog.
///
/// [alertType] represents the type of alert to be shown.
/// [message] is the message to be displayed in the alert dialog.
///
/// Returns a Future that resolves to the result value of the dialog.
showAlert({
  final AlertType? alertType,
  final String? message,
}) {
  return showDialog(
    barrierDismissible: false,
    context: NavObserver.navKey.currentContext!,
    builder: (context) {
      return ShowMessage(alertType: alertType, message: message);
    },
  );
}
