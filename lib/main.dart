import 'package:flutter/material.dart';
import 'package:movies_app/theme/app_colors.dart';
import 'package:movies_app/widgets/auth/auth_widget.dart';
import 'package:movies_app/widgets/main_screen/main_screen_widget.dart';
import 'package:movies_app/widgets/movie_details/movie_details_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.mainDarkBlue,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.mainDarkBlue,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
        ),
      ),
      routes: {
        '/auth': (context) => const AuthWidget(),
        '/main_screen': (context) => const MainScreenWidget(),
        '/main_screen/movie_details': (context) => const MovieDetailsWidget(),
      },
      initialRoute: '/auth',
    );
  }
}
