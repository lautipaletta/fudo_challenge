import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.freezed.dart';

@freezed
abstract class AuthState with _$AuthState {
  const factory AuthState({
    @Default(null) String? email,
    @Default(false) bool isAuthenticated,
  }) = _AuthState;

  factory AuthState.initial() => const AuthState();
}
