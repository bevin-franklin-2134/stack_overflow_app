import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:stack_overflow_app/helper/nav_observer.dart';
import 'package:stack_overflow_app/ui/screens/search_screen.dart';
import 'package:stack_overflow_app/ui/screens/webview_screen.dart';

/// Constant representing the route for the web view screen.
const String webViewScreen = '/webViewScreen';

/// Constant representing the default route.
const String route = '/';

/// Function to generate routes based on the provided [RouteSettings].
///
/// Returns a [Route] object for the given route settings.
Route<Object?>? generateRoute(RouteSettings settings) {
  return getRoute(settings.name);
}

/// Function to get a specific route based on the provided route [name] and optional arguments [args].
///
/// Returns a [Route] object for the specified route name and arguments.
Route<Object?>? getRoute(String? name, {LinkedHashMap? args, Function? result}) {
  switch (name) {
    case route:
      return MaterialPageRoute(
          builder: (context) => const SearchScreen(),
          settings: RouteSettings(name: name));
    case webViewScreen:
      return MaterialPageRoute(
          builder: (context) =>  WebViewScreen(args: args!),
          settings: RouteSettings(name: name));
  }
  return null;
}

/// Function to open a screen specified by [routeName].
///
/// Optional parameters
/// - [forceNew]=> Whether to force opening a new instance of the screen.
/// - [requiresAsInitial]=> Whether the screen should be set as the initial route.
/// - [args]=> Optional arguments to pass to the screen.
/// - [result]=> Optional callback function for handling the result from the screen.
openScreen(String routeName,
    {bool forceNew = false,
      bool requiresAsInitial = false,
      LinkedHashMap? args, Function? result}) async {
  var route = getRoute(routeName, args: args, result: result);
  var context = NavObserver.navKey.currentContext;
  if (route != null && context != null) {
    if (requiresAsInitial) {
      Navigator.pushAndRemoveUntil(context, route, (route) => false);
    } else if (forceNew || !NavObserver.instance.containsRoute(route)) {
      await Navigator.push(context, route);
    } else {
      Navigator.popUntil(context, (route) {
        if (route.settings.name == routeName) {
          if (args != null) {
            (route.settings.arguments as Map)["result"] = args;
          }
          return true;
        }
        return false;
      });
    }
  }
}

/// Function to navigate back to the previous screen.
///
/// Optional parameter
/// - [args]=> Optional arguments to pass back to the previous screen.
void back([LinkedHashMap? args]) {
  if (NavObserver.navKey.currentContext != null) {
    Navigator.pop(NavObserver.navKey.currentContext!, args);
  }
}
