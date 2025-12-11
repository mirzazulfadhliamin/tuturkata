import 'package:get_it/get_it.dart';
import 'package:tutur_kata/feature/exercise/presentation/bloc/exercise/exercise_bloc.dart';
import 'package:tutur_kata/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:tutur_kata/feature/auth/presentation/bloc/auth_repository.dart';
import 'package:tutur_kata/feature/home/presentation/bloc/home_bloc.dart';
import 'package:tutur_kata/feature/home/presentation/bloc/home_repository.dart';

import 'package:tutur_kata/feature/exercise/presentation/bloc/exercise/exercise_repository.dart';
import 'package:tutur_kata/feature/exercise/presentation/bloc/exercise_detail/exercise_detail_bloc.dart';
import 'package:tutur_kata/feature/exercise/presentation/bloc/exercise_detail/exercise_detail_repository.dart';
import 'package:tutur_kata/feature/profile/presentation/bloc/profile_bloc.dart';
import 'package:tutur_kata/feature/profile/presentation/bloc/profile_repository.dart';

import 'feature/exercise/presentation/bloc/exercise_level/exercise_level_bloc.dart';
import 'feature/exercise/presentation/bloc/exercise_level/exercise_level_repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton(() => AuthRepository());
  sl.registerLazySingleton(() => HomeRepository());
  sl.registerLazySingleton(() => ExerciseRepository());
  sl.registerLazySingleton(() => ExerciseDetailRepository());
  sl.registerLazySingleton(() => ProfileRepository());

  sl.registerLazySingleton(() => ExerciseLevelRepository());

  sl.registerFactory<AuthBloc>(() => AuthBloc(sl<AuthRepository>()));
  sl.registerFactory<HomeBloc>(() => HomeBloc(sl<HomeRepository>()));
  sl.registerFactory<ExerciseBloc>(() => ExerciseBloc(sl<ExerciseRepository>()));
  sl.registerFactory<ExerciseDetailBloc>(() => ExerciseDetailBloc(sl<ExerciseDetailRepository>()));
  sl.registerFactory<ExerciseLevelBloc>(() => ExerciseLevelBloc(sl<ExerciseLevelRepository>()));
  sl.registerFactory<ProfileBloc>(() => ProfileBloc(sl<ProfileRepository>()));

}
