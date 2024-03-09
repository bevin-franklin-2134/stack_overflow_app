import 'package:flutter/material.dart';

/// A widget for displaying a search input field with a search icon button.
class SearchWidget extends StatelessWidget {
  /// The controller for the search input field.
  final TextEditingController controller;

  /// The function to handle search action.
  final Function() handleSearch;

  /// Constructor for the [SearchWidget] widget.
  const SearchWidget({
    required this.controller,
    required this.handleSearch,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: (val) {
        final previousCursorPosition = controller.selection;
        controller.text = val;
        controller.selection = previousCursorPosition;
      },
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color:Theme.of(context).colorScheme.primary ),
      onEditingComplete: handleSearch,
      onFieldSubmitted: (val) {
        handleSearch;
      },
      decoration: InputDecoration(
        suffixIcon: IconButton(
          color: Theme.of(context).primaryColor,
          onPressed: handleSearch,
          icon:  Icon(Icons.search,color:Theme.of(context).colorScheme.primary),
        ),
        hintText: 'Search here...',
        hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(color:Theme.of(context).colorScheme.primary ),
        enabledBorder: OutlineInputBorder(
          borderRadius: _buildBorderRadius(),
        ),
        border: OutlineInputBorder(
          borderRadius: _buildBorderRadius(),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: _buildBorderRadius(),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: _buildBorderRadius(),
        ),
      ),
    );
  }

  /// Builds and returns the border radius for the input field.
  BorderRadius _buildBorderRadius() =>
      const BorderRadius.all(Radius.circular(12));
}
