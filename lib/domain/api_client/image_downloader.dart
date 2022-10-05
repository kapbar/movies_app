import 'package:movies_app/configuration/configuration.dart';

class ImageDownloader {
  static String imageUrl(String path) => Configuration.imageUrl + path;
}
