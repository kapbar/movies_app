import 'package:movies_app/domain/api_client/account_api_client.dart';
import 'package:movies_app/domain/api_client/auth_api_client.dart';
import 'package:movies_app/domain/data_providers/session_data_providers.dart';

class AuthService {
  final _accountApiClient = AccountApiClient();
  final _sessionDataProvider = SessionDataProvider();
  final _authApiClient = AuthApiClient();

  Future<bool> isAuth() async {
    final sessionId = await _sessionDataProvider.getSessionId();
    final isAuth = sessionId != null;
    return isAuth;
  }

  Future<void> login(String login, String password) async {
    final sessionId = await _authApiClient.auth(
      username: login,
      password: password,
    );
    final accountId = await _accountApiClient.getAccountInfo(sessionId);

    await _sessionDataProvider.setSessionId(sessionId);
    await _sessionDataProvider.setAccountId(accountId);
  }
}
