import 'package:cinemapedia/domain/entities/movie.dart';

abstract class LocalStorageDatasource {
  Future<void> toggleFavoriteMovie(Movie movie);
  Future<bool> isMovieFavorite(int movieId);
  Future<List<Movie>> loadFavoriteMovies({
    int limit = 10,
    int offset = 0,
  });
}
