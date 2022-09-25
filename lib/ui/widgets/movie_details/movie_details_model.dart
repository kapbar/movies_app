import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movies_app/domain/api_client/api_client.dart';
import 'package:movies_app/domain/entity/movie_details.dart';

class MovieDetailsModel extends ChangeNotifier {
  final _apiClient = ApiClient();
  final int movieId;
  late String _locale;
  MovieDetails? _movieDetails;
  late DateFormat _dateFormat;

  MovieDetailsModel(this.movieId);

  MovieDetails? get movieDetails => _movieDetails;

  // String stringFromDate(DateTime? date) =>
  //     date != null ? _dateFormat.format(date) : '';

  Future<void> setupLocale(BuildContext context) async {
    final locale = Localizations.localeOf(context).toLanguageTag();
    if (_locale == locale) return;
    _locale = locale;
    _dateFormat = DateFormat.yMMMMd(locale);
    await loadDetails();
  }

  Future<void> loadDetails() async {
    _movieDetails = await _apiClient.movieDetails(movieId, _locale);
    notifyListeners();
  }
}
