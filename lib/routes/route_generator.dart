import 'package:flutter/material.dart';

import '../screens/screens.dart';
import 'route_constants.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.initial:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );

      case Routes.resultScreen:
        if (settings.arguments is String) {
          final comparisonResult = settings.arguments as String;
          return MaterialPageRoute(
            builder: (_) => ResultScreen(comparisonResult: comparisonResult),
          );
        } else {
          return _errorRoute();
        }

      case Routes.uploadReferenceScreen:
        return MaterialPageRoute(
          builder: (_) => const UploadReferenceScreen(),
        );

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
