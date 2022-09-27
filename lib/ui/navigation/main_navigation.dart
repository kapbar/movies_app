import 'package:flutter/material.dart';
import 'package:movies_app/library/widgets/inherited/provider.dart';
import 'package:movies_app/ui/widgets/auth/auth_model.dart';
import 'package:movies_app/ui/widgets/auth/auth_widget.dart';
import 'package:movies_app/ui/widgets/main_screen/main_screen_model.dart';
import 'package:movies_app/ui/widgets/main_screen/main_screen_widget.dart';
import 'package:movies_app/ui/widgets/movie_details/movie_details_model.dart';
import 'package:movies_app/ui/widgets/movie_details/movie_details_widget.dart';
import 'package:movies_app/ui/widgets/movie_details/movie_trailer.dart';

abstract class MainNavigationRouteName {
  static const auth = 'auth';
  static const mainScreen = '/';
  static const movieDetails = '/movie_details';
  static const movieTrailer = '/movie_details/trailer';

}

class MainNavigation {
  String initialRoute(bool isAuth) => isAuth
      ? MainNavigationRouteName.mainScreen
      : MainNavigationRouteName.auth;
  final routes = <String, Widget Function(BuildContext)>{
    MainNavigationRouteName.auth: (context) => NotifierProvider(
          create: () => AuthModel(),
          child: const AuthWidget(),
        ),
    MainNavigationRouteName.mainScreen: (context) => NotifierProvider(
          create: () => MainScreenModel(),
          child: const MainScreenWidget(),
        ),
  };
  Route<Object> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainNavigationRouteName.movieDetails:
        final arguments = settings.arguments;
        final movieId = arguments is int ? arguments : 0;
        return MaterialPageRoute(
          builder: (context) => NotifierProvider(
            create: () => MovieDetailsModel(movieId),
            child: const MovieDetailsWidget(),
          ),
        );
        case MainNavigationRouteName.movieTrailer:
        final arguments = settings.arguments;
        final youtubeKey = arguments is String ? arguments : '';
        return MaterialPageRoute(
          builder: (context) => MovieTrailer(youtubeKey: youtubeKey),
        );
      default:
        const widget = Text('Navigation Error!!!');
        return MaterialPageRoute(builder: (context) => widget);
    }
  }
}
