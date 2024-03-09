import 'package:flutter/material.dart';
import 'package:stack_overflow_app/helper/nav_helper.dart';
import 'package:stack_overflow_app/ui/widget/button_widget.dart';

/// A widget to display an alert dialog with a message and an icon based on the alert type.
class ShowMessage extends StatelessWidget {
  /// The type of alert.
  final AlertType? alertType;

  /// The message to display in the alert.
  final String? message;

  /// Constructor for the [ShowMessage] widget.
  const ShowMessage({
    this.alertType,
    this.message,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: _getIcon(alertType),
      title: Text(
        'Stack Overflow',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      content: Text(
        message ?? '',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      contentPadding: const EdgeInsets.all(20),
      actions: [
        ButtonWidget(
          buttonText: 'Ok',
          onChange: () {
            back(null);
          },
        )
      ],
    );
  }

  /// Returns the icon based on the alert type.
  Widget _getIcon(AlertType? alertType) {
    Widget widget;
    switch (alertType) {
      case AlertType.ERROR:
        {
          widget = const Icon(Icons.error, color: Colors.red);
          break;
        }
      case AlertType.INFO:
        {
          widget = const Icon(Icons.details, color: Colors.yellow);
          break;
        }
      default:
        {
          widget = const Icon(Icons.info);
          break;
        }
    }
    return widget;
  }
}

/// Enum representing different types of alerts.
enum AlertType {
  ERROR,
  INFO,
}
