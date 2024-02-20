import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie_db/app_constants.dart';
import 'package:flutter_movie_db/movie/pages/movie_page.dart';
import 'package:flutter_movie_db/movie/providers/movie_get_discover_providers.dart';
import 'package:flutter_movie_db/movie/repository/movie_repository.dart';
import 'package:flutter_movie_db/movie/repository/movie_repository_impl.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  final dioOptions = BaseOptions(
      baseUrl: AppConstants.baseUrl,
      queryParameters: {'api_key': AppConstants.apiKey});

  final Dio dio = Dio(dioOptions);
  final MovieRepository movieRepository = MovieRepositoryImpl(dio);
  runApp(App(movieRepository: movieRepository));
  FlutterNativeSplash.remove();
}

class App extends StatelessWidget {
  const App({super.key, required this.movieRepository});

  final MovieRepository movieRepository;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MovieGetDiscoverProvider(movieRepository),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MoviePage(),
      ),
    );
  }
}
