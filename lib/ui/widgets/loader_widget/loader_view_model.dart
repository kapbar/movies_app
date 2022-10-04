import 'package:flutter/cupertino.dart';
import 'package:movies_app/domain/services/auth_service.dart';
import 'package:movies_app/ui/navigation/main_navigation.dart';

class LoaderViewModel {
  final BuildContext context;
  final _authService = AuthService();

  LoaderViewModel(this.context) {
    asyncInit();
  }

  Future<void> asyncInit() async {
    await checkAuth();
  }

  Future<void> checkAuth([bool mounted = true]) async {
    final isAuth = await _authService.isAuth();
    final nextScreen = isAuth
        ? MainNavigationRouteName.mainScreen
        : MainNavigationRouteName.auth;

    if (!mounted) return;
    Navigator.of(context).pushReplacementNamed(nextScreen);
  }
}
