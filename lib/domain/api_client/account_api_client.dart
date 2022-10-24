import 'package:movies_app/configuration/configuration.dart';
import 'package:movies_app/domain/api_client/network_client.dart';

enum MediaType { movie, tv }

extension MediaTypeAsString on MediaType {
  String asString() {
    switch (this) {
      case MediaType.movie:
        return 'movie';
      case MediaType.tv:
        return 'tv';
    }
  }
}

class AccountApiClient {
  final _networkClient = NetworkClient();

  Future<int> getAccountInfo(String sessionId) async {
    int parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = jsonMap['id'] as int;
      return response;
    }

    final result = _networkClient.gett(
      '/account',
      parser,
      {
        'api_key': Configuration.apiKey,
        'session_id': sessionId,
      },
    );
    return result;
  }

  Future<String> markAsFavorite({
    required int accountId,
    required String sessionId,
    required MediaType mediaType,
    required int mediaId,
    required bool isFavorite,
  }) async {
    final parameters = <String, dynamic>{
      'media_type': mediaType.asString(),
      'media_id': mediaId,
      "favorite": isFavorite,
    };
    String parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final token = jsonMap["request_token"] as String;
      return token;
    }

    final result = _networkClient.post(
      '/account/$accountId/favorite',
      parser,
      parameters,
      {
        'api_key': Configuration.apiKey,
        'session_id': sessionId,
      },
    );
    return result;
  }
}
