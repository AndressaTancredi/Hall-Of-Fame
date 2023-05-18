import 'package:calcada_da_fama/pages/home_page.dart';
import 'package:calcada_da_fama/pages/scan_page.dart';
import 'package:flutter/material.dart';

import '../pages/signature_page.dart';

class AppRouter {
  Route onGeneratedRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/home_page':
        return MaterialPageRoute(builder: (_) => const HomePage());
      case '/scan_page':
        return MaterialPageRoute(builder: (_) => const ScanPage());
      case '/signature_page':
        return MaterialPageRoute(builder: (_) => const SignaturePage());
      default:
        throw ArgumentError('Inexistent route: s${routeSettings.name}');
    }
  }
}
