import 'package:flutter/material.dart';

import '../../screens/login_screen.dart';
import '../../screens/profile_screen.dart';
import 'navigation_routes.dart';

GlobalKey<NavigatorState> navigationKey = GlobalKey();
RouteSettings? routeSettings;

class NavigationRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    routeSettings = settings;

    switch (settings.name) {
      case Screens.login:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );
      case Screens.profile:
        return MaterialPageRoute(
          builder: (_) => const ProfileScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );
    }
  }

  static void pushReplacement(BuildContext context, String routeName,
      {Object? arguments}) {
    Navigator.of(context).pushReplacementNamed(routeName, arguments: arguments);
  }

  static Future<dynamic> push(BuildContext context, String routeName,
      {Object? arguments}) {
    return Navigator.of(context).pushNamed(routeName, arguments: arguments);
  }

  static void pop(BuildContext context, {dynamic args}) {
    Navigator.of(context).pop(args);
  }

  static void popUntil(BuildContext context, String routeName, {dynamic args}) {
    Navigator.popUntil(context, ModalRoute.withName(routeName));
  }

  static Future<dynamic> pushAndRemoveUntil(
      BuildContext context, String routeName,
      {Object? arguments}) {
    return Navigator.of(context).pushNamedAndRemoveUntil(
        routeName, (route) => false,
        arguments: arguments);
  }
}