import 'package:calcada_da_fama/common/text_styles.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton(() => TextStyles());
}
