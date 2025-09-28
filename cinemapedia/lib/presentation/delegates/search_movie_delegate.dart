import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';

typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

class SearchMovieDelegate extends SearchDelegate<Movie?> {
  List<Movie> initialMovies;
  final SearchMoviesCallback searchMovies;
  StreamController<List<Movie>> debounceMovies = StreamController.broadcast();
  StreamController<bool> isLoadingStream = StreamController.broadcast();
  Timer? _debounceTimer;

  SearchMovieDelegate(
      {this.initialMovies = const [], required this.searchMovies});

  void clearStreams() {
    debounceMovies.close();
  }

  void onQueryChanged(String query) {
    isLoadingStream.add(true);
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
    _debounceTimer = Timer(Duration(milliseconds: 300), () async {
      // if (query.isEmpty) {
      //   debounceMovies.add([]);
      //   return;
      // }
      final movies = await searchMovies(query);
      debounceMovies.add(movies);
      initialMovies = movies;
      isLoadingStream.add(false);
    });
  }

  Widget buildResultsAndSuggestions() {
    return StreamBuilder(
        initialData: initialMovies,
        stream: debounceMovies.stream,
        builder: (context, snapshot) {
          final movies = snapshot.data ?? [];

          return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              return _MovieItem(
                  movie: movie,
                  onMovieSelected: (context, movie) {
                    clearStreams();
                    close(context, movie);
                  });
            },
          );
        });
  }

  @override
  String get searchFieldLabel => 'Buscar película';

  @override
  List<Widget>? buildActions(Object context) {
    return [
      StreamBuilder(
          initialData: false,
          stream: isLoadingStream.stream,
          builder: (context, snapshot) {
            if (snapshot.data ?? false) {
              return SpinPerfect(
                duration: Duration(seconds: 20),
                spins: 10,
                child: IconButton(
                  icon: Icon(Icons.refresh_rounded),
                  onPressed: () {
                    query = '';
                  },
                ),
              );
            }
            return FadeIn(
              animate: query.isNotEmpty,
              duration: Duration(milliseconds: 300),
              child: IconButton(
                icon: Icon(Icons.clear),
                onPressed: () {
                  query = '';
                },
              ),
            );
          }),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios_new_rounded),
      onPressed: () {
        clearStreams();
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildResultsAndSuggestions();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    onQueryChanged(query);
    return buildResultsAndSuggestions();
  }
}

class _MovieItem extends StatelessWidget {
  final Movie movie;
  final Function onMovieSelected;

  const _MovieItem({required this.movie, required this.onMovieSelected});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        onMovieSelected(context, movie);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            // image
            SizedBox(
              width: size.width * 0.2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  movie.posterPath,
                  loadingBuilder: (context, child, loadingProgress) =>
                      FadeIn(child: child),
                ),
              ),
            ),
            SizedBox(width: 10),
            SizedBox(
              width: size.width * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(movie.title, style: textStyles.titleMedium),
                  if (movie.overview.length > 100)
                    Text('${movie.overview.substring(0, 100)}...')
                  else
                    Text(movie.overview),
                  Row(
                    children: [
                      Icon(Icons.star_half, color: Colors.yellow.shade800),
                      SizedBox(width: 5),
                      Text(
                        HumanFormats.number(movie.voteAverage),
                        style: textStyles.bodyMedium
                            ?.copyWith(color: Colors.yellow.shade800),
                      )
                    ],
                  )
                ],
              ),
            )
            // description
          ],
        ),
      ),
    );
  }
}
