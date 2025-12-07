import 'package:get_it/get_it.dart';
import 'core/bloc/test.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton(() => ExampleBloc());
}
