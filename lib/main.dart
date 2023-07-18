import 'package:calcada_da_fama/model/form_data.dart';
import 'package:calcada_da_fama/pages/start_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/injection_container.dart' as get_it;
import 'common/app_router.dart';

void main() {
  get_it.init();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => FormDataModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Calçada da Fama',
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: const StartPage(),
        onGenerateRoute: AppRouter().onGeneratedRoute,
      ),
    );
  }
}
