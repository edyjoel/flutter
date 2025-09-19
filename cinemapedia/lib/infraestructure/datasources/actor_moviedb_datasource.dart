import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/actors_datasource.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/infraestructure/mappers/actor_mapper.dart';
import 'package:cinemapedia/infraestructure/models/moviedb/credits_response.dart';
import 'package:dio/dio.dart';

class ActorMovieDbDatasource extends ActorsDatasource {
  final dio = Dio(BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.movieDbKey,
        'language': 'es-MX'
      }));

  @override
  Future<List<Actor>> getActorsByMovieId(String movieId) async {
    final response = await dio.get('/movie/$movieId/credits');
    if (response.statusCode != 200) {
      throw Exception('Actors for movie with id: $movieId not found');
    }
    if (response.data == null) {
      throw Exception('Actors for movie with id: $movieId not found');
    }

    final castResponse = CreditsResponse.fromJson(response.data);

    List<Actor> actors = castResponse.cast
        .map((cast) => ActorMapper.castToEntity(cast))
        .toList();

    return actors;
  }
}
