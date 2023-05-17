import 'package:calcada_da_fama/pages/home_page.dart';
import 'package:flutter/material.dart';

import 'common/app_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calçada da Fama',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const HomePage(),
      onGenerateRoute: _appRouter.onGeneratedRoute,
    );
  }
}
