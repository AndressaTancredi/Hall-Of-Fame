import 'dart:typed_data';

import 'package:calcada_da_fama/pages/home_page.dart';
import 'package:calcada_da_fama/pages/result_page.dart';
import 'package:calcada_da_fama/pages/scan_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/form_data.dart';
import '../pages/share_page.dart';
import '../pages/signature_page.dart';

class AppRouter {
  Route onGeneratedRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/home_page':
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider<FormDataModel>(
            create: (_) => FormDataModel(),
            child: const HomePage(),
          ),
        );
      case '/scan_page':
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider<FormDataModel>(
            create: (_) => FormDataModel(),
            child: const ScanPage(),
          ),
        );
      case '/signature_page':
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider<FormDataModel>(
            create: (_) => FormDataModel(),
            child: const SignaturePage(),
          ),
        );
      case '/result_page':
        final Uint8List photo = (routeSettings.arguments
            as Map<String, dynamic>)['photo'] as Uint8List;
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider<FormDataModel>(
            create: (_) => FormDataModel(),
            child: ResultPage(photo: photo),
          ),
        );
      case '/share_page':
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider<FormDataModel>(
            create: (_) => FormDataModel(),
            child: const SharePage(
              qrCodeImageLink: '',
            ),
          ),
        );
      default:
        throw ArgumentError('Inexistent route: ${routeSettings.name}');
    }
  }
}
