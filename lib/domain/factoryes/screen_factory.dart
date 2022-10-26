import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/domain/blocs/auth_bloc.dart';
import 'package:movies_app/ui/widgets/main_screen/main_screen_widget.dart';
import 'package:movies_app/ui/widgets/movie_details/movie_details_model.dart';
import 'package:movies_app/ui/widgets/movie_details/movie_details_widget.dart';
import 'package:movies_app/ui/widgets/movie_details/movie_trailer.dart';
import 'package:movies_app/ui/widgets/movie_list/movie_list_model.dart';
import 'package:movies_app/ui/widgets/movie_list/movie_list_widget.dart';
import 'package:movies_app/ui/widgets/news/news_screen.dart';
import 'package:movies_app/ui/widgets/tv_show/tv_show_screen.dart';
import 'package:provider/provider.dart';
import 'package:movies_app/ui/widgets/auth/auth_model.dart';
import 'package:movies_app/ui/widgets/auth/auth_widget.dart';
import 'package:movies_app/ui/widgets/loader_widget/loader_view_cubit.dart';
import 'package:movies_app/ui/widgets/loader_widget/loader_widget.dart';

class ScreenFactory {
  AuthBloc? _authBloc;
  Widget makeLoader() {
    final authBloc = _authBloc ?? AuthBloc(AuthCheckStatusInprogressState());
    _authBloc = authBloc;
    return BlocProvider<LoaderViewCubit>(
      create: (context) =>
          LoaderViewCubit(LoaderViewCubitState.unknown, authBloc),
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
    _authBloc?.close();
    _authBloc = null;
    return const MainScreenWidget();
  }

  Widget makeMovieDetails(int movieId) {
    return ChangeNotifierProvider(
      create: (_) => MovieDetailsModel(movieId),
      child: const MovieDetailsWidget(),
    );
  }

  Widget makeMovieTrailer(String youtubeKey) {
    return MovieTrailer(youtubeKey: youtubeKey);
  }

  Widget makeNewsList() {
    return const NewsScreen();
  }

  Widget makeMovieList() {
    return ChangeNotifierProvider(
      create: (_) => MovieListViewModel(),
      child: const MovieListWidget(),
    );
  }

  Widget makeTvShowList() {
    return const TvShowScreen();
  }
}
