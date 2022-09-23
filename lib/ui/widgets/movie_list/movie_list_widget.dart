import 'package:flutter/material.dart';
import 'package:movies_app/ui/navigation/main_navigation.dart';

class Movie {
  final int id;
  final String imageName;
  final String title;
  final String time;
  final String description;

  const Movie({
    required this.id,
    required this.imageName,
    required this.title,
    required this.time,
    required this.description,
  });
}

class MovieListWidget extends StatefulWidget {
  const MovieListWidget({super.key});

  @override
  State<MovieListWidget> createState() => _MovieListWidgetState();
}

class _MovieListWidgetState extends State<MovieListWidget> {
  static const _movies = <Movie>[
    Movie(
      id: 1,
      imageName: 'imageName',
      title: 'Quen and King',
      time: ' April 7, 2022',
      description: 'If you signed up but did not get your verification email.',
    ),
    Movie(
      id: 2,
      imageName: 'imageName',
      title: 'Шахматы',
      time: ' April 7, 2022',
      description: 'If you signed up but did not get your verification email.',
    ),
    Movie(
      id: 3,
      imageName: 'imageName',
      title: 'Королева',
      time: ' April 7, 2022',
      description: 'If you signed up but did not get your verification email.',
    ),
    Movie(
      id: 4,
      imageName: 'imageName',
      title: 'Флаттер',
      time: ' April 7, 2022',
      description: 'If you signed up but did not get your verification email.',
    ),
    Movie(
      id: 5,
      imageName: 'imageName',
      title: 'Дарт язык',
      time: ' April 7, 2022',
      description: 'If you signed up but did not get your verification email.',
    ),
    Movie(
      id: 6,
      imageName: 'imageName',
      title: 'OPP Solid',
      time: ' April 7, 2022',
      description: 'If you signed up but did not get your verification email.',
    ),
    Movie(
      id: 7,
      imageName: 'imageName',
      title: 'Anime 22',
      time: ' April 7, 2022',
      description: 'If you signed up but did not get your verification email.',
    ),
  ];

  var _filteredMovie = <Movie>[];

  final _searchController = TextEditingController();

  void _searchMovie() {
    final query = _searchController.text;
    if (query.isNotEmpty) {
      _filteredMovie = _movies.where((Movie movie) {
        return movie.title.toLowerCase().contains(query.toLowerCase());
      }).toList();
    } else {
      _filteredMovie = _movies;
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _filteredMovie = _movies;
    _searchController.addListener(_searchMovie);
  }

  void _onMovieTap(int index) {
    final id = _movies[index].id;
    Navigator.of(context).pushNamed(
      MainNavigationRouteName.movieDetails,
      arguments: id,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
          padding: const EdgeInsets.only(top: 70.0),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          itemCount: _filteredMovie.length,
          itemExtent: 163,
          itemBuilder: (BuildContext context, int index) {
            final movie = _movies[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black.withOpacity(0.2)),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: Row(
                      children: [
                        const Placeholder(
                          fallbackWidth: 120,
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),
                              Text(
                                movie.title,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 5),
                              Text(
                                movie.time,
                                style: const TextStyle(color: Colors.grey),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 20),
                              Text(
                                movie.description,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                      ],
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10.0),
                      onTap: () => _onMovieTap(index),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Поиск',
              filled: true,
              fillColor: Colors.white.withAlpha(235),
              border: const OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }
}
