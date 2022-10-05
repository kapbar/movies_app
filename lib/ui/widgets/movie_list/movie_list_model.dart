import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movies_app/domain/api_client/movie_api_client.dart';
import 'package:movies_app/domain/entity/movie.dart';
import 'package:movies_app/domain/entity/popular_movie_response.dart';
import 'package:movies_app/ui/navigation/main_navigation.dart';

class MovieListModel extends ChangeNotifier {
  final _apiClient = MovieApiClient();
  final _movies = <Movie>[];
  late DateFormat _dateFormat;
  late int _currentPage;
  late int _totalPage;
  var _isLoadingProgress = false;
  String _locale = '';
  String? _searchQuery;
  Timer? searchDebounce;

  List<Movie> get movies => List.unmodifiable(_movies);

  String stringFromDate(DateTime? date) =>
      date != null ? _dateFormat.format(date) : '';

  Future<void> setupLocale(BuildContext context) async {
    final locale = Localizations.localeOf(context).toLanguageTag();
    if (_locale == locale) return;
    _locale = locale;
    _dateFormat = DateFormat.yMMMMd(locale);
    await _resetList();
  }

  Future<void> _resetList() async {
    _currentPage = 0;
    _totalPage = 1;
    _movies.clear();
    await _loadNextPage();
  }

  Future<PopularMovieResponse> _loadMovies(int nextPage, String locale) async {
    final query = _searchQuery;
    if (query == null) {
      return await _apiClient.popularMovie(nextPage, locale);
    } else {
      return await _apiClient.searchMovie(nextPage, locale, query);
    }
  }

  Future<void> _loadNextPage() async {
    if (_isLoadingProgress || _currentPage >= _totalPage) return;
    _isLoadingProgress = true;
    final nextPage = _currentPage + 1;
    try {
      final movieResponse = await _loadMovies(nextPage, _locale);
      _movies.addAll(movieResponse.movies);
      _currentPage = movieResponse.page;
      _totalPage = movieResponse.totalPages;
      _isLoadingProgress = false;
      notifyListeners();
    } catch (e) {
      _isLoadingProgress = false;
    }
  }

  void onMovieTap(BuildContext context, int index) {
    final id = _movies[index].id;
    Navigator.of(context).pushNamed(
      MainNavigationRouteName.movieDetails,
      arguments: id,
    );
  }

  Future<void> searchMovie(String text) async {
    searchDebounce?.cancel();
    searchDebounce = Timer(const Duration(milliseconds: 300), () async {
      final searchQuery = text.isNotEmpty ? text : null;
      if (_searchQuery == searchQuery) return;
      _searchQuery = searchQuery;
      await _resetList();
    });
  }

  void showedMovieAtIndex(int index) {
    if (index < _movies.length - 1) return;
    _loadNextPage();
  }
}
