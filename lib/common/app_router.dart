import 'package:flutter/material.dart';

import '../pages/home_page.dart';

class AppRouter {
  Route onGeneratedRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/home_page':
        return MaterialPageRoute(builder: (_) => const HomePage());
      default:
        throw ArgumentError('Inexistent route: s${routeSettings.name}');
    }
  }
}
