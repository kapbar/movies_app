import 'package:flutter/material.dart';
import 'package:movies_app/domain/api_client/image_downloader.dart';
import 'package:movies_app/ui/widgets/movie_details/movie_details_model.dart';
import 'package:provider/provider.dart';

class ScreenCastWidget extends StatelessWidget {
  const ScreenCastWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Series Cast',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(
            height: 380,
            child: Scrollbar(
              child: ActorsListWidget(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextButton(
              onPressed: () {},
              child: const Text('Full Cast & Crew'),
            ),
          ),
        ],
      ),
    );
  }
}

class ActorsListWidget extends StatelessWidget {
  const ActorsListWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cast = context.select((MovieDetailsModel model) => model.data.cast);
    if (cast.isEmpty) return const SizedBox.shrink();
    return ListView.builder(
      itemCount: cast.length,
      itemExtent: 140,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return ActorListItem(index: index);
      },
    );
  }
}

class ActorListItem extends StatelessWidget {
  final int index;
  const ActorListItem({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final actor = context.read<MovieDetailsModel>().data.cast[index];
    final profilePath = actor.profilePath;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.black.withOpacity(0.2),
          ),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          clipBehavior: Clip.hardEdge,
          child: Column(
            children: [
              if (profilePath != null)
                Image.network(ImageDownloader.imageUrl(profilePath)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      actor.name,
                      maxLines: 1,
                    ),
                    const SizedBox(height: 7),
                    Text(
                      actor.character,
                      maxLines: 4,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '${actor.castId} Episodes',
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
