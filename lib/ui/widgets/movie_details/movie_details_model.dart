// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:movies_app/domain/api_client/api_client_exception.dart';
import 'package:movies_app/domain/entity/movie_details.dart';
import 'package:movies_app/domain/services/auth_service.dart';
import 'package:movies_app/domain/services/movie_service.dart';
import 'package:movies_app/ui/navigation/main_navigation.dart';

import '../../../domain/entity/movie_details_casts.dart';

class MovieDetailsPosterData {
  final String? backdropPath;
  final String? posterPath;
  final bool isFavorite;
  IconData get favoriteIcon =>
      isFavorite ? Icons.favorite : Icons.favorite_outline_outlined;

  MovieDetailsPosterData({
    this.backdropPath,
    this.posterPath,
    this.isFavorite = false,
  });

  MovieDetailsPosterData copyWith({
    String? backdropPath,
    String? posterPath,
    bool? isFavorite,
  }) {
    return MovieDetailsPosterData(
      backdropPath: backdropPath ?? this.backdropPath,
      posterPath: posterPath ?? this.posterPath,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

class MovieDetailsScoreData {
  final String? trailerKey;
  final double voteAverage;

  MovieDetailsScoreData({
    this.trailerKey,
    required this.voteAverage,
  });
}

class MovieDetailsTableData {
  final String name;
  final String job;

  MovieDetailsTableData({
    required this.name,
    required this.job,
  });
}

class MovieDetailsData {
  String title = '';
  bool isLoading = true;
  String overview = '';
  MovieDetailsPosterData posterData = MovieDetailsPosterData();
  String year = '';
  MovieDetailsScoreData scoreData = MovieDetailsScoreData(voteAverage: 0);
  String summary = '';
  List<List<MovieDetailsTableData>> tableData =
      const <List<MovieDetailsTableData>>[];
  List<Actor> cast = const <Actor>[];
}

class MovieDetailsModel extends ChangeNotifier {
  final _authService = AuthService();
  final _movieService = MovieService();
  final data = MovieDetailsData();
  final int movieId;
  String _locale = '';
  late DateFormat _dateFormat;

  MovieDetailsModel(this.movieId);

  void updateData(MovieDetails? details, bool isFavorite) {
    data.title = details?.title ?? 'Загрузка...';
    data.isLoading = details == null;
    if (details == null) {
      notifyListeners();
      return;
    }
    data.overview = details.overview ?? '';
    data.posterData = MovieDetailsPosterData(
      backdropPath: details.backdropPath,
      posterPath: details.posterPath,
      isFavorite: isFavorite,
    );
    var year = details.releaseDate?.year.toString();
    year = year != null ? ' ($year)' : '';
    data.year = year;
    final videos = details.videos.results
        .where((video) => video.type == 'Trailer' && video.site == 'YouTube');
    final trailerKey = videos.isNotEmpty == true ? videos.first.key : null;
    data.scoreData = MovieDetailsScoreData(
      trailerKey: trailerKey,
      voteAverage: details.voteAverage,
    );
    data.summary = makeSummary(details);
    data.tableData = maketableData(details);
    data.cast = details.credits.cast;
    notifyListeners();
  }

  List<List<MovieDetailsTableData>> maketableData(MovieDetails details) {
    var crew = details.credits.crew
        .map((e) => MovieDetailsTableData(job: e.job, name: e.name))
        .toList();
    crew = crew.length > 4 ? crew.sublist(0, 4) : crew;
    var crewChunks = <List<MovieDetailsTableData>>[];
    for (var i = 0; i < crew.length; i += 2) {
      crewChunks.add(
        crew.sublist(i, i + 2 > crew.length ? crew.length : i + 2),
      );
    }
    return crewChunks;
  }

  String makeSummary(MovieDetails details) {
    var text = <String>[];
    final releaseDate = details.releaseDate;
    if (releaseDate != null) {
      text.add(_dateFormat.format(releaseDate));
    }
    if (details.productionCountries.isNotEmpty) {
      text.add('(${details.productionCountries.first.iso})');
    }
    final runtime = details.runtime ?? 0;
    final miliseconds = runtime * 60000;
    final runtimeDate = DateTime.fromMillisecondsSinceEpoch(miliseconds);
    text.add(DateFormat.Hm().format(runtimeDate));

    if (details.genres.isNotEmpty) {
      var genresNames = <String>[];
      for (var genr in details.genres) {
        genresNames.add(genr.name);
      }

      text.add(genresNames.join(', '));
    }
    return text.join(' ');
  }

  Future<void> setupLocale(BuildContext context, Locale locale) async {
    final localeTag = locale.toLanguageTag();
    if (_locale == localeTag) return;
    _locale = localeTag;
    _dateFormat = DateFormat.yMMMMd(localeTag);
    updateData(null, false);
    await loadDetails(context);
  }

  Future<void> loadDetails(
    BuildContext context, [
    bool mounted = true,
  ]) async {
    try {
      final details = await _movieService.loadDetails(movieId, _locale);
      updateData(details.details, details.isFavorite);
    } on ApiClientException catch (e) {
      switch (e.type) {
        case ApiClientExceptionType.sessionExpired:
          _authService.logout();
          if (!mounted) return;
          MainNavigation.resetNavigation(context);
          break;
        default:
          print(e);
      }
    }
  }

  Future<void> toggleFavorite(
    BuildContext context, [
    bool mounted = true,
  ]) async {
    data.posterData =
        data.posterData.copyWith(isFavorite: !data.posterData.isFavorite);
    notifyListeners();
    try {
      await _movieService.updateFavorite(movieId, data.posterData.isFavorite);
    } on ApiClientException catch (e) {
      switch (e.type) {
        case ApiClientExceptionType.sessionExpired:
          _authService.logout();
          if (!mounted) return;
          MainNavigation.resetNavigation(context);
          break;
        default:
          print(e);
      }
    }
  }
}
