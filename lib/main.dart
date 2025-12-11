import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tutur_kata/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:tutur_kata/feature/exercise/presentation/bloc/exercise_bloc.dart';
import 'core/bloc/test.dart';

import 'core/route/app_route.dart';
import 'core/theme/app_theme.dart';
import 'feature/home/presentation/bloc/home_bloc.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ExampleBloc>(create: (_) => di.sl<ExampleBloc>()),
        BlocProvider<AuthBloc>(create: (_) => di.sl<AuthBloc>()),
        BlocProvider<HomeBloc>(create: (context) => HomeBloc()),
        BlocProvider<ExerciseBloc>(create: (_) => di.sl<ExerciseBloc>()),
      ],
      child: MaterialApp(
        title: "Flutter BLoC Setup",
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRoute().onGenerateRoute,
        initialRoute: "/",
      ),
    );
  }
}




