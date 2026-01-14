import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movies_app/core/resources/app_router.dart';
import 'package:movies_app/core/services/service_locator.dart';
import 'package:movies_app/core/resources/app_strings.dart';
import 'package:movies_app/core/resources/app_theme.dart';
import 'package:movies_app/movies/presentation/controllers/movies_bloc/movies_bloc.dart';
import 'package:movies_app/movies/presentation/controllers/movies_bloc/movies_event.dart';
import 'package:movies_app/tv_shows/presentation/controllers/tv_shows_bloc/tv_shows_bloc.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:movies_app/profile/presentation/controllers/profile_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load();

  ServiceLocator.init();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<MoviesBloc>()..add(GetMoviesEvent()),
        ),
        BlocProvider(
          create: (context) => sl<TVShowsBloc>()..add(GetTVShowsEvent()),
        ),
        BlocProvider(
          create: (context) => ProfileCubit(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appTitle,
      theme: getApplicationTheme(),
      routerConfig: AppRouter.router,
    );
  }
}
