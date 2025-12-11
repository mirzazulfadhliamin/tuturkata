import 'package:get_it/get_it.dart';
import 'package:tutur_kata/feature/home/presentation/bloc/home_bloc.dart';
import 'package:tutur_kata/feature/home/presentation/bloc/home_repository.dart';
import 'core/bloc/test.dart';
import 'feature/auth/presentation/bloc/auth_bloc.dart';
import 'feature/auth/presentation/bloc/auth_repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton(() => ExampleBloc());
  sl.registerLazySingleton<AuthRepository>(() => AuthRepository());

  sl.registerFactory<AuthBloc>(
        () => AuthBloc(sl<AuthRepository>()),
  );

  sl.registerFactory<HomeBloc>(
        () => HomeBloc(sl<HomeRepository>()),
  );
}
