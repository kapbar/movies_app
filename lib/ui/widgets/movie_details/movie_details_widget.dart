import 'package:flutter/material.dart';
import 'package:movies_app/ui/widgets/movie_details/main_info_widget.dart';
import 'package:movies_app/ui/widgets/movie_details/screen_cast_widget.dart';

class MovieDetailsWidget extends StatefulWidget {
  const MovieDetailsWidget({super.key});

  @override
  State<MovieDetailsWidget> createState() => _MovieDetailsWidgetState();
}

class _MovieDetailsWidgetState extends State<MovieDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TMDB'),
        centerTitle: true,
      ),
      body: ColoredBox(
        color: const Color.fromRGBO(24, 23, 27, 1.0),
        child: ListView(
          children: const [
            MainInfoWidget(),
            ScreenCastWidget(),
          ],
        ),
      ),
    );
  }
}
