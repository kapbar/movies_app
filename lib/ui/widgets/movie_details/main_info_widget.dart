import 'package:flutter/material.dart';
import 'package:movies_app/domain/api_client/image_downloader.dart';
import 'package:movies_app/ui/navigation/main_navigation.dart';
import 'package:movies_app/ui/widgets/elements/radial_percent_widget.dart';
import 'package:movies_app/ui/widgets/movie_details/movie_details_model.dart';
import 'package:provider/provider.dart';

class MainInfoWidget extends StatelessWidget {
  const MainInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        TopPosterWidget(),
        MovieNameWidget(),
        ScoreWidget(),
        SummeryWidget(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Text(
            'Overview',
            style: TextStyle(
              fontSize: 22,
              color: Colors.white,
            ),
          ),
        ),
        DescriptionWidget(),
        SizedBox(height: 30),
        TableWidget(),
      ],
    );
  }
}

class DescriptionWidget extends StatelessWidget {
  const DescriptionWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final overview = context.select((MovieDetailsModel m) => m.data.overview);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        overview,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.white,
        ),
      ),
    );
  }
}

class TopPosterWidget extends StatelessWidget {
  const TopPosterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.read<MovieDetailsModel>();
    final posterData =
        context.select((MovieDetailsModel m) => m.data.posterData);
    final backdropPath = posterData.backdropPath;
    final posterPath = posterData.posterPath;
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Stack(
        children: [
          if (backdropPath != null)
            Image.network(ImageDownloader.imageUrl(backdropPath)),
          if (posterPath != null)
            Positioned(
              top: 20,
              left: 20,
              bottom: 20,
              child: Image.network(ImageDownloader.imageUrl(posterPath)),
            ),
          Positioned(
            top: 5,
            right: 5,
            child: IconButton(
              onPressed: () => model.toggleFavorite(context),
              icon: Icon(posterData.favoriteIcon),
            ),
          ),
        ],
      ),
    );
  }
}

class MovieNameWidget extends StatelessWidget {
  const MovieNameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final title = context.select((MovieDetailsModel m) => m.data.title);
    final year = context.select((MovieDetailsModel m) => m.data.year);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: RichText(
          textAlign: TextAlign.center,
          maxLines: 3,
          text: TextSpan(
            children: [
              TextSpan(
                text: title,
                style: const TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextSpan(
                text: year,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ScoreWidget extends StatelessWidget {
  const ScoreWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final scoreData =
        context.select((MovieDetailsModel model) => model.data.scoreData);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
          onPressed: () {},
          child: Row(
            children: [
              SizedBox(
                width: 55,
                height: 55,
                child: RadialPercentWidget(
                  percent: scoreData.voteAverage / 10,
                  fillColor: const Color.fromARGB(255, 10, 23, 25),
                  lineColor: const Color.fromARGB(255, 37, 203, 103),
                  freeColor: const Color.fromARGB(255, 25, 54, 31),
                  lineWidth: 3.5,
                  child: Text(
                    '${scoreData.voteAverage * 10}%',
                    style: const TextStyle(color: Colors.white, fontSize: 13),
                  ),
                ),
              ),
              const SizedBox(width: 5),
              const Text('User Score'),
            ],
          ),
        ),
        Container(width: 1, height: 20, color: Colors.grey),
        if (scoreData.trailerKey != null)
          TextButton(
            onPressed: () => Navigator.of(context).pushNamed(
              MainNavigationRouteName.movieTrailer,
              arguments: scoreData.trailerKey,
            ),
            child: Row(
              children: const [
                Icon(Icons.play_arrow, color: Colors.white),
                SizedBox(width: 5),
                Text('Play Trailer'),
              ],
            ),
          ),
      ],
    );
  }
}

class SummeryWidget extends StatelessWidget {
  const SummeryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final summary =
        context.select((MovieDetailsModel model) => model.data.summary);
    return ColoredBox(
      color: const Color.fromARGB(255, 16, 13, 26),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                summary,
                textAlign: TextAlign.center,
                maxLines: 3,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TableWidget extends StatelessWidget {
  const TableWidget({super.key});

  @override
  Widget build(BuildContext context) {
    const nameStyle = TextStyle(
      color: Colors.white,
      fontSize: 17,
      fontWeight: FontWeight.bold,
    );
    const jobTitleStyle = TextStyle(
      color: Colors.white,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    );
    final tableData =
        context.select((MovieDetailsModel model) => model.data.tableData);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(tableData.first.first.name, style: nameStyle),
                    Text(tableData.first.first.job, style: jobTitleStyle),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(tableData.first.first.name, style: nameStyle),
                    Text(tableData.first.first.job, style: jobTitleStyle),
                  ],
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(tableData.last.last.name, style: nameStyle),
                    Text(tableData.last.last.job, style: jobTitleStyle),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(tableData.last.last.name, style: nameStyle),
                    Text(tableData.last.last.job, style: jobTitleStyle),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
