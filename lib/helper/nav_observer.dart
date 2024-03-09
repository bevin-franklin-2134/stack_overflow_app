import 'package:flutter/material.dart';

/// A custom navigator observer to track route history and perform specific actions.
class NavObserver extends NavigatorObserver {
  /// List to store the history of routes.
  List<Route?> routeHistory = [];

  /// Singleton instance of NavObserver.
  static NavObserver instance = NavObserver();

  /// Global key for accessing the navigator state.
  static var navKey = GlobalKey<NavigatorState>();

  @override
  void didPush(Route route, Route? previousRoute) {
    if (route.settings.name != null && route.settings.name!.isNotEmpty) {
      routeHistory.add(route);
    }
    super.didPush(route, previousRoute);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    if (navKey.currentContext != null) {
      //----navKey.currentContext!.read<OnboardingCubit>().clearReq();
    }

    routeHistory.remove(route);
    super.didPop(route, previousRoute);
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    var beginIndex = routeHistory.indexOf(route);
    var endIndex = routeHistory.indexOf(previousRoute);
    if ((endIndex == -1 && beginIndex != -1) || beginIndex - 1 == endIndex) {
      routeHistory.remove(route);
    } else if (endIndex != -1 && beginIndex != -1) {
      routeHistory.removeRange(beginIndex, endIndex);
    }
    super.didRemove(route, previousRoute);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    if (routeHistory.contains(oldRoute)) {
      routeHistory[routeHistory.indexOf(oldRoute)] = newRoute;
    }
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }

  /// Checks if the route history contains the given route.
  ///
  /// Returns `true` if the route history contains the given route, `false` otherwise.
  bool containsRoute(Route<dynamic>? route) {
    if (route != null) {
      for (var history in routeHistory) {
        if (history?.settings.name == route.settings.name) {
          return true;
        }
      }
    }
    return false;
  }
}
