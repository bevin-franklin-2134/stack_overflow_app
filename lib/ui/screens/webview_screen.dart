import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:stack_overflow_app/helper/nav_helper.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatelessWidget {
  String url = ''; // The URL of the web page to load
  ValueNotifier<bool> isLoaded = ValueNotifier(false); // Notifier for tracking web page loading state

  // Constructor to initialize the URL from arguments
  WebViewScreen({
    required LinkedHashMap args, // Arguments passed to the screen
    super.key,
  }) {
    if (args.containsKey('url')) {
      url = args['url'];
    }
  }

  @override
  Widget build(BuildContext context) {
    // Create a WebViewController instance to control the WebView
    var controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted) // Enable JavaScript
      ..setBackgroundColor(const Color(0x00000000)) // Set background color to transparent
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading progress if needed
          },
          onPageStarted: (String url) {
            debugPrint(url); // Print URL when page starts loading
          },
          onPageFinished: (String url) {
            debugPrint(url); // Print URL when page finishes loading
            isLoaded.value = true; // Notify that the page has finished loading
          },
          onWebResourceError: (WebResourceError error) {
            // Handle web resource errors if needed
          },
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate; // Allow navigation to requested URL
          },
        ),
      )
      ..loadRequest(Uri.parse(url)); // Load the specified URL

    // Build the scaffold with app bar, web view, and loading indicator
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            back(null); // Navigate back when back button is pressed
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(
          'Stack Overflow', // Title of the app bar
          style: Theme.of(context).textTheme.titleLarge?.copyWith(color:Theme.of(context).colorScheme.primary ), // Apply large title text style
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            WebViewWidget(
              controller: controller, // Pass the web view controller to the WebViewWidget
            ),
            ValueListenableBuilder(
              valueListenable: isLoaded,
              builder: (context, bool loaded, child) {
                // Show loading indicator while page is loading
                return Visibility(
                  visible: !loaded,
                  child: const Center(child: CircularProgressIndicator()),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
