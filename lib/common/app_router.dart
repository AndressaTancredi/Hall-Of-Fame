import 'dart:typed_data';

import 'package:calcada_da_fama/pages/home_page.dart';
import 'package:calcada_da_fama/pages/result_page.dart';
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
      case '/result_page':
        final Uint8List photo = (routeSettings.arguments
            as Map<String, dynamic>)['photo'] as Uint8List;
        return MaterialPageRoute(builder: (_) => ResultPage(photo: photo));
      default:
        throw ArgumentError('Inexistent route: ${routeSettings.name}');
    }
  }
}
