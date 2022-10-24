import 'package:flutter/material.dart';
import 'package:movies_app/ui/widgets/movie_details/main_info_widget.dart';
import 'package:movies_app/ui/widgets/movie_details/movie_details_model.dart';
import 'package:movies_app/ui/widgets/movie_details/screen_cast_widget.dart';
import 'package:provider/provider.dart';

class MovieDetailsWidget extends StatefulWidget {
  const MovieDetailsWidget({super.key});

  @override
  State<MovieDetailsWidget> createState() => _MovieDetailsWidgetState();
}

class _MovieDetailsWidgetState extends State<MovieDetailsWidget> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final locale = Localizations.localeOf(context);
    Future.microtask(
      () => context.read<MovieDetailsModel>().setupLocale(context, locale),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const _TitleWidget(),
        centerTitle: true,
      ),
      body: const ColoredBox(
        color: Color.fromRGBO(24, 23, 27, 1.0),
        child: _BodyWidget(),
      ),
    );
  }
}

class _TitleWidget extends StatelessWidget {
  const _TitleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final title = context.select((MovieDetailsModel m) => m.data.title);
    return Text(title);
  }
}

class _BodyWidget extends StatelessWidget {
  const _BodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select((MovieDetailsModel m) => m.data.isLoading);
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return ListView(
      children: const [
        MainInfoWidget(),
        ScreenCastWidget(),
      ],
    );
  }
}
