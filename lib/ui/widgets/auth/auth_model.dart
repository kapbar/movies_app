import 'package:flutter/material.dart';
import 'package:movies_app/domain/api_client/api_client.dart';
import 'package:movies_app/domain/data_providers/session_data_providers.dart';
import 'package:movies_app/ui/navigation/main_navigation.dart';

class AuthModel extends ChangeNotifier {
  final _apiClient = ApiClient();
  final _sessionDataProvider = SessionDataProvider();
  final loginTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  bool _isAuthProgress = false;
  bool get canStartAuth => !_isAuthProgress;
  bool get isAuthProgress => _isAuthProgress;

  Future<void> auth(BuildContext context, [bool mounted = true]) async {
    final login = loginTextController.text;
    final password = passwordTextController.text;

    if (login.isEmpty || password.isEmpty) {
      _errorMessage = 'Заполниет логин и пароль';
      notifyListeners();
      return;
    }
    _errorMessage = null;
    _isAuthProgress = true;
    notifyListeners();
    String? sessionId;
    try {
      sessionId = await _apiClient.auth(
        username: login,
        password: password,
      );
    } on ApiClientException catch (e) {
      switch (e.type) {
        case ApiClientExceptionType.network:
          _errorMessage = 'Сервер не доступен. Проверьте инет';
          break;
        case ApiClientExceptionType.auth:
          _errorMessage = 'Неправильный логин или пароль';
          break;
        case ApiClientExceptionType.other:
          _errorMessage = 'Произашла ошибка. Повторите еще раз';
          break;
      }
    }
    _isAuthProgress = false;
    if (_errorMessage != null) {
      notifyListeners();
      return;
    }
    if (sessionId == null) {
      _errorMessage = 'PPFPFPFPF{} ошибка!!!!!';
      notifyListeners();
      return;
    }
    await _sessionDataProvider.setSessionId(sessionId);
    if (!mounted) return;
    Navigator.of(context)
        .pushReplacementNamed(MainNavigationRouteName.mainScreen);
  }
}
