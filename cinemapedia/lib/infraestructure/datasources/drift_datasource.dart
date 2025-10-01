import 'package:drift/drift.dart' as drift;
import 'package:cinemapedia/config/database/database.dart';
import 'package:cinemapedia/domain/datasources/local_storage_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';

class DriftDatasource extends LocalStorageDatasource {
  final AppDatabase database;

  DriftDatasource([AppDatabase? database]) : database = database ?? db;

  @override
  Future<bool> isMovieFavorite(int movieId) async {
    final query = database.select(database.favoriteMovies)
      ..where((table) => table.movieId.equals(movieId));
    final favoriteMovie = await query.getSingleOrNull();
    return favoriteMovie != null;
  }

  @override
  Future<List<Movie>> loadFavoriteMovies(
      {int limit = 10, int offset = 0}) async {
    final query = database.select(database.favoriteMovies)
      ..limit(limit, offset: offset);
    final favoriteMovies = await query.get();

    final movies = favoriteMovies
        .map((movie) => Movie(
            adult: false,
            backdropPath: movie.backdropPath,
            genreIds: [],
            id: movie.movieId,
            originalLanguage: '',
            originalTitle: movie.originalTitle,
            overview: '',
            popularity: 0,
            posterPath: movie.posterPath,
            releaseDate: DateTime.now(),
            title: movie.title,
            video: false,
            voteAverage: movie.voteAverage,
            voteCount: 0))
        .toList();

    return movies;
  }

  @override
  Future<void> toggleFavoriteMovie(Movie movie) async {
    final isFavorite = await isMovieFavorite(movie.id);

    if (isFavorite) {
      final deleteQuery = database.delete(database.favoriteMovies)
        ..where((table) => table.movieId.equals(movie.id));
      await deleteQuery.go();
      return;
    }

    await database.into(database.favoriteMovies).insert(
          FavoriteMoviesCompanion.insert(
              movieId: movie.id,
              backdropPath: movie.backdropPath,
              originalTitle: movie.originalTitle,
              posterPath: movie.posterPath,
              title: movie.title,
              voteAverage: drift.Value(movie.voteAverage)),
        );
  }
}
