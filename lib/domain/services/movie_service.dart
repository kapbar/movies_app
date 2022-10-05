import 'package:movies_app/configuration/configuration.dart';
import 'package:movies_app/domain/api_client/movie_api_client.dart';
import 'package:movies_app/domain/entity/popular_movie_response.dart';

class MovieService {
  final _movieApiClient = MovieApiClient();

  Future<PopularMovieResponse> popularMovie(int page, String locale) async {
    return _movieApiClient.popularMovie(page, locale, Configuration.apiKey);
  }

  Future<PopularMovieResponse> searchMovie(
    int page,
    String locale,
    String query,
  ) async =>
      _movieApiClient.searchMovie(page, locale, query, Configuration.apiKey);
}
