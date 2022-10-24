import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

import 'package:movies_app/domain/api_client/account_api_client.dart';
import 'package:movies_app/domain/api_client/auth_api_client.dart';
import 'package:movies_app/domain/data_providers/session_data_providers.dart';

abstract class AuthEvent {}

class AuthCheckStatusEvent extends AuthEvent {}

class AuthLogoutEvent extends AuthEvent {}

class AuthLogintEvent extends AuthEvent {
  final String login;
  final String password;

  AuthLogintEvent({
    required this.login,
    required this.password,
  });
}

enum AuthStateStatus { authorized, notAuthorized, inProgress }

abstract class AuthState {}

class AuthAuthorizedState extends AuthState {
  @override
  bool operator ==(Object other) =>
      other is AuthAuthorizedState && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class AuthUnAuthorizedState extends AuthState {
  @override
  bool operator ==(Object other) =>
      other is AuthUnAuthorizedState && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class AuthFailureState extends AuthState {
  final Object error;

  AuthFailureState(this.error);

  @override
  bool operator ==(covariant AuthFailureState other) {
    if (identical(this, other)) return true;

    return other.error == error;
  }

  @override
  int get hashCode => error.hashCode;
}

class AuthInprogressState extends AuthState {
  @override
  bool operator ==(Object other) =>
      other is AuthInprogressState && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class AuthCheckStatusInprogressState extends AuthState {
  @override
  bool operator ==(Object other) =>
      other is AuthCheckStatusInprogressState &&
      runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final _accountApiClient = AccountApiClient();
  final _sessionDataProvider = SessionDataProvider();
  final _authApiClient = AuthApiClient();

  AuthBloc(super.initialState) {
    on<AuthEvent>((event, emit) async {
      if (event is AuthCheckStatusEvent) {
        await onAuthCheckStatusEvent(event, emit);
      } else if (event is AuthLogintEvent) {
        await onAuthLogintEvent(event, emit);
      } else if (event is AuthLogoutEvent) {
        await onAuthLogoutEvent(event, emit);
      }
    }, transformer: sequential());

    add(AuthCheckStatusEvent());
  }

  Future<void> onAuthCheckStatusEvent(
    AuthCheckStatusEvent event,
    Emitter<AuthState> emit,
  ) async {
    final sessionId = await _sessionDataProvider.getSessionId();
    final newState =
        sessionId != null ? AuthAuthorizedState() : AuthUnAuthorizedState();
    emit(newState);
  }

  Future<void> onAuthLogintEvent(
    AuthLogintEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final sessionId = await _authApiClient.auth(
        username: event.login,
        password: event.password,
      );
      final accountId = await _accountApiClient.getAccountInfo(sessionId);

      await _sessionDataProvider.setSessionId(sessionId);
      await _sessionDataProvider.setAccountId(accountId);
      emit(AuthAuthorizedState());
    } catch (e) {
      emit(AuthFailureState(e));
    }
  }

  Future<void> onAuthLogoutEvent(
    AuthLogoutEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      await _sessionDataProvider.deleteSessionId();
      await _sessionDataProvider.deleteAccountId();
      emit(AuthUnAuthorizedState());
    } catch (e) {
      emit(AuthFailureState(e));
    }
  }
}
