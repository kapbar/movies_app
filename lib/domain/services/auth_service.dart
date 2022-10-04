import 'package:movies_app/domain/data_providers/session_data_providers.dart';

class AuthService {
  final _sessionDataProvider = SessionDataProvider();

  Future<bool> isAuth() async {
    final sessionId = await _sessionDataProvider.getSessionId();
    final isAuth = sessionId != null;
    return isAuth;
  }
}
