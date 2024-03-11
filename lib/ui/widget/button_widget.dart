import 'package:flutter/material.dart';

/// A customizable text button widget.
class ButtonWidget extends StatelessWidget {
  /// The text to display on the button.
  final String buttonText;

  /// The callback function to be called when the button is pressed.
  final Function() onChange;

  /// Constructor for the [ButtonWidget].
  const ButtonWidget({
    super.key,
    required this.buttonText,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 10),
        ),
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          // If the button is pressed, return the primary color, otherwise blue
          if (states.contains(MaterialState.pressed)) {
            return Theme.of(context).primaryColor;
          }
          return Colors.blue;
        }),
      ),
      onPressed: onChange,
      child: Text(
        buttonText,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}
