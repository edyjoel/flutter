import 'package:cinemapedia/config/router/app_router.dart';
import 'package:cinemapedia/config/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await db.into(db.favoriteMovies).insert(FavoriteMoviesCompanion.insert(
  //       movieId: 1,
  //       backdropPath: 'path',
  //       originalTitle: 'title',
  //       posterPath: 'path',
  //       title: 'title',
  //     ));

  // final deleteQuery = db.delete(db.favoriteMovies)
  // ..where((tbl) => tbl.movieId.equals(1));

  // await deleteQuery.go();

  // final moviesQuery = await db.select(db.favoriteMovies).get();
  // print('Movies in database:');
  // print(moviesQuery);

  // final deleteAllQuery = db.delete(db.favoriteMovies);
  // await deleteAllQuery.go();

  await dotenv.load(fileName: ".env");
  runApp(
    ProviderScope(
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getTheme(),
      routerConfig: appRouter,
    );
  }
}
