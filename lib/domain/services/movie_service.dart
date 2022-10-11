import 'package:movies_app/configuration/configuration.dart';
import 'package:movies_app/domain/api_client/account_api_client.dart';
import 'package:movies_app/domain/api_client/movie_api_client.dart';
import 'package:movies_app/domain/data_providers/session_data_providers.dart';
import 'package:movies_app/domain/entity/popular_movie_response.dart';
import 'package:movies_app/domain/local_entity/movie_details_local.dart';

class MovieService {
  final _movieApiClient = MovieApiClient();
  final _sessionDataProvider = SessionDataProvider();
  final _accountApiClient = AccountApiClient();

  Future<PopularMovieResponse> popularMovie(int page, String locale) async {
    return _movieApiClient.popularMovie(page, locale, Configuration.apiKey);
  }

  Future<PopularMovieResponse> searchMovie(
    int page,
    String locale,
    String query,
  ) async =>
      _movieApiClient.searchMovie(page, locale, query, Configuration.apiKey);

  Future<MovieDetailsLocal> loadDetails(
    int movieId,
    String locale, [
    bool mounted = true,
  ]) async {
    final movieDetails = await _movieApiClient.movieDetails(movieId, locale);
    final sessionId = await _sessionDataProvider.getSessionId();
    var isFavorite = false;
    if (sessionId != null) {
      isFavorite = await _movieApiClient.isFavorite(movieId, sessionId);
    }
    return MovieDetailsLocal(isFavorite: isFavorite, details: movieDetails);
  }

  Future<void> updateFavorite(
    int movieId,
    bool isFavorite, [
    bool mounted = true,
  ]) async {
    final sessionId = await _sessionDataProvider.getSessionId();
    final accountId = await _sessionDataProvider.getAccountId();
    if (sessionId == null || accountId == null) return;
    await _accountApiClient.markAsFavorite(
      accountId: accountId,
      sessionId: sessionId,
      mediaType: MediaType.movie,
      mediaId: movieId,
      isFavorite: isFavorite,
    );
  }
}
