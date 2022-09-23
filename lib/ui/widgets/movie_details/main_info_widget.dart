import 'package:flutter/material.dart';
import 'package:movies_app/ui/widgets/elements/radial_percent_widget.dart';

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
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'TopPosterWidget extends StatelessWidget Overview Widget build(BuildContext context. TopPosterWidget extends StatelessWidget Overview Widget build(BuildContext context Overview Widget build(BuildContext context)',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(height: 30),
        TableWidget(),
      ],
    );
  }
}

class TopPosterWidget extends StatelessWidget {
  const TopPosterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: const [
        Placeholder(fallbackHeight: 220),
        Positioned(
          top: 20,
          left: 20,
          bottom: 20,
          child: Placeholder(fallbackHeight: 180, fallbackWidth: 120),
        ),
      ],
    );
  }
}

class MovieNameWidget extends StatelessWidget {
  const MovieNameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: RichText(
          textAlign: TextAlign.center,
          maxLines: 3,
          text: const TextSpan(
            children: [
              TextSpan(
                text: 'Tom Clancy Without Remorse',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextSpan(
                text: ' (2022)',
                style: TextStyle(fontSize: 16),
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
          onPressed: () {},
          child: Row(
            children: const [
              SizedBox(
                width: 55,
                height: 55,
                child: RadialPercentWidget(
                  percent: 0.72,
                  fillColor: Color.fromARGB(255, 10, 23, 25),
                  lineColor: Color.fromARGB(255, 37, 203, 103),
                  freeColor: Color.fromARGB(255, 25, 54, 31),
                  lineWidth: 3.5,
                  child: Text(
                    '72%',
                    style: TextStyle(color: Colors.white, fontSize: 13),
                  ),
                ),
              ),
              SizedBox(width: 5),
              Text('User Score'),
            ],
          ),
        ),
        Container(width: 1, height: 20, color: Colors.grey),
        TextButton(
          onPressed: () {},
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
    return const ColoredBox(
      color: Color.fromARGB(255, 16, 13, 26),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 70),
        child: Text(
          'R, 04/29/2022 (US) Action, Adventure, Thriller, War',
          textAlign: TextAlign.center,
          maxLines: 3,
          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.w400,
          ),
        ),
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
                  children: const [
                    Text('Stefano Sollima', style: nameStyle),
                    Text('Director', style: jobTitleStyle),
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
                  children: const [
                    Text('Stefano Sollima', style: nameStyle),
                    Text('Director', style: jobTitleStyle),
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
                  children: const [
                    Text('Stefano Sollima', style: nameStyle),
                    Text('Director', style: jobTitleStyle),
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
                  children: const [
                    Text('Stefano Sollima', style: nameStyle),
                    Text('Director', style: jobTitleStyle),
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
