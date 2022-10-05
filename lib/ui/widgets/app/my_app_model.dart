import 'package:flutter/material.dart';
import 'package:movies_app/domain/data_providers/session_data_providers.dart';
import 'package:movies_app/ui/navigation/main_navigation.dart';

class MyAppModel {
  final _sessionDataProvider = SessionDataProvider();
  var _isAuth = false;
  bool get isAuth => _isAuth;

  Future<void> checkAuth() async {
    final sessionId = await _sessionDataProvider.getSessionId();
    _isAuth = sessionId != null;
  }

  Future<void> resetSession(BuildContext context, [bool mounted = true]) async {
    await _sessionDataProvider.setSessionId(null);
    await _sessionDataProvider.setAccountId(null);
    if (!mounted) return;
    await Navigator.of(context).pushNamedAndRemoveUntil(
      MainNavigationRouteName.auth,
      (route) => false,
    );
  }
}
