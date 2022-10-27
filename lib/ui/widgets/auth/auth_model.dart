import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'package:movies_app/domain/api_client/api_client_exception.dart';
import 'package:movies_app/domain/blocs/auth_bloc.dart';
import 'package:movies_app/domain/services/auth_service.dart';
import 'package:movies_app/ui/navigation/main_navigation.dart';

abstract class AuthViewCubitState {}

class AuthViewCubitSuccesFormFillInProgressState extends AuthViewCubitState {
  @override
  bool operator ==(Object other) =>
      other is AuthViewCubitSuccesFormFillInProgressState &&
      runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class AuthViewCubitErrorState extends AuthViewCubitState {
  final String errorMessage;

  AuthViewCubitErrorState(this.errorMessage);

  @override
  bool operator ==(covariant AuthViewCubitErrorState other) {
    if (identical(this, other)) return true;

    return other.errorMessage == errorMessage;
  }

  @override
  int get hashCode => errorMessage.hashCode;
}

class AuthViewCubitAuthProgressState extends AuthViewCubitState {
  @override
  bool operator ==(Object other) =>
      other is AuthViewCubitAuthProgressState &&
      runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class AuthViewCubitSuccesAuthState extends AuthViewCubitState {
  @override
  bool operator ==(Object other) =>
      other is AuthViewCubitSuccesAuthState && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class AuthViewCubit extends Cubit<AuthViewCubitState> {
  final AuthBloc authBloc;
  late final StreamSubscription<AuthState> authBlocSubscription;
  AuthViewCubit(super.initialState, this.authBloc);

  bool _isValid(String login, String password) =>
      login.isNotEmpty && password.isNotEmpty;

  void auth({required String login, required String password}) {
    if (!_isValid(login, password)) {
      final state = AuthViewCubitErrorState('Заполниет логин и пароль');
      emit(state);
      return;
    }
    authBloc.add(AuthLogintEvent(login: login, password: password));
  }

  void _onState(AuthState state) {
    if (state is AuthUnAuthorizedState) {
      emit(AuthViewCubitSuccesFormFillInProgressState());
    } else if (state is AuthAuthorizedState) {
      emit(AuthViewCubitSuccesAuthState());
    } else if (state is AuthFailureState) {
      final state = AuthViewCubitErrorState('Заполниет логин и пароль');
      emit(state);
    }
  }

  @override
  Future<void> close() {
    authBlocSubscription.cancel();
    return super.close();
  }
}

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
