import 'package:movies_app/configuration/configuration.dart';
import 'package:movies_app/domain/api_client/network_client.dart';
import 'package:movies_app/domain/entity/movie_details.dart';
import 'package:movies_app/domain/entity/popular_movie_response.dart';

class MovieApiClient {
  final _networkClient = NetworkClient();

  Future<PopularMovieResponse> popularMovie(
    int page,
    String locale,
    String apiKey,
  ) async {
    PopularMovieResponse parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = PopularMovieResponse.fromJson(jsonMap);
      return response;
    }

    final result = _networkClient.gett(
      '/movie/popular',
      parser,
      {
        'api_key': apiKey,
        'page': page.toString(),
        'language': locale,
      },
    );
    return result;
  }

  Future<PopularMovieResponse> searchMovie(
    int page,
    String locale,
    String query,
    String apiKey,
  ) async {
    PopularMovieResponse parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = PopularMovieResponse.fromJson(jsonMap);
      return response;
    }

    final result = _networkClient.gett(
      '/search/movie',
      parser,
      {
        'api_key': apiKey,
        'page': page.toString(),
        'language': locale,
        'query': query,
        'include_adult': true.toString(),
      },
    );
    return result;
  }

  Future<MovieDetails> movieDetails(int movieId, String locale) async {
    MovieDetails parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = MovieDetails.fromJson(jsonMap);
      return response;
    }

    final result = _networkClient.gett(
      '/movie/$movieId',
      parser,
      {
        'append_to_response': 'credits,videos',
        'api_key': Configuration.apiKey,
        'language': locale,
      },
    );
    return result;
  }

  Future<bool> isFavorite(int movieId, String sessionId) async {
    bool parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = jsonMap['favorite'] as bool;
      return response;
    }

    final result = _networkClient.gett(
      '/movie/$movieId/account_states',
      parser,
      {
        'api_key': Configuration.apiKey,
        'session_id': sessionId,
      },
    );
    return result;
  }
}
