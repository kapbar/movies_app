import 'package:flutter/material.dart';
import 'package:movies_app/domain/api_client/api_client_exception.dart';
import 'package:movies_app/domain/services/auth_service.dart';
import 'package:movies_app/ui/navigation/main_navigation.dart';

class AuthViewModel extends ChangeNotifier {
  final _authService = AuthService();
  final loginTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  bool _isAuthProgress = false;
  bool get canStartAuth => !_isAuthProgress;
  bool get isAuthProgress => _isAuthProgress;

  bool _isValid(String login, String password) =>
      login.isNotEmpty && password.isNotEmpty;

  Future<String?> _login(String login, String password) async {
    try {
      await _authService.login(login, password);
    } on ApiClientException catch (e) {
      switch (e.type) {
        case ApiClientExceptionType.network:
          return 'Сервер не доступен. Проверьте инет';
        case ApiClientExceptionType.auth:
          return 'Неправильный логин или пароль';
        case ApiClientExceptionType.sessionExpired:
        case ApiClientExceptionType.other:
          return 'Произашла ошибка. Повторите еще раз';
      }
    } catch (e) {
      return 'Oшибка!!!!!';
    }
    return null;
  }

  Future<void> auth(BuildContext context, [bool mounted = true]) async {
    final login = loginTextController.text;
    final password = passwordTextController.text;

    if (!_isValid(login, password)) {
      _updateState('Заполниет логин и пароль', false);
      return;
    }
    _updateState(null, true);

    _errorMessage = await _login(login, password);
    if (!mounted) return;
    if (_errorMessage == null) {
      MainNavigation.resetNavigation(context);
    } else {
      _updateState(_errorMessage, false);
    }
  }

  void _updateState(String? errorMessage, bool isAuthProgress) {
    if (_errorMessage == errorMessage && _isAuthProgress == isAuthProgress) {
      return;
    }
    _errorMessage = errorMessage;
    _isAuthProgress = isAuthProgress;
    notifyListeners();
  }
}
