import 'package:flutter/material.dart';
import 'package:movies_app/ui/widgets/main_screen/main_screen_model.dart';
import 'package:movies_app/ui/widgets/main_screen/main_screen_widget.dart';
import 'package:movies_app/ui/widgets/movie_details/movie_details_model.dart';
import 'package:movies_app/ui/widgets/movie_details/movie_details_widget.dart';
import 'package:movies_app/ui/widgets/movie_details/movie_trailer.dart';
import 'package:provider/provider.dart';
import 'package:movies_app/library/widgets/inherited/provider.dart'
    as old_provider;
import 'package:movies_app/ui/widgets/auth/auth_model.dart';
import 'package:movies_app/ui/widgets/auth/auth_widget.dart';
import 'package:movies_app/ui/widgets/loader_widget/loader_view_model.dart';
import 'package:movies_app/ui/widgets/loader_widget/loader_widget.dart';

class ScreenFactory {
  Widget makeLoader() {
    return Provider(
      create: (context) => LoaderViewModel(context),
      lazy: false,
      child: const LoaderWidget(),
    );
  }

  Widget makeAuth() {
    return ChangeNotifierProvider(
      create: (_) => AuthViewModel(),
      child: const AuthWidget(),
    );
  }

  Widget makeMainScreen() {
    return old_provider.NotifierProvider(
      create: () => MainScreenModel(),
      child: const MainScreenWidget(),
    );
  }

  Widget makeMovieDetails(int movieId) {
    return old_provider.NotifierProvider(
      create: () => MovieDetailsModel(movieId),
      child: const MovieDetailsWidget(),
    );
  }

  Widget makeMovieTrailer(String youtubeKey) {
    return MovieTrailer(youtubeKey: youtubeKey);
  }
}
