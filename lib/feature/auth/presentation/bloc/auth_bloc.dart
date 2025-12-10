import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import 'auth_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository;

  AuthBloc(this.repository) : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<RegisterRequested>(_onRegisterRequested);
  }

  Future<void> _onLoginRequested(
      LoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final token = await repository.login(event.email, event.password);
      emit(AuthSuccess(token));
    } catch (e) {
      if (e is DioException) {
        final message = e.response?.data["detail"] ??
            "Terjadi kesalahan server, silakan coba lagi.";
        emit(AuthFailure(message));
      } else {
        emit(AuthFailure(e.toString()));
      }
    }
  }

  Future<void> _onRegisterRequested(
      RegisterRequested event,
      Emitter<AuthState> emit,
      ) async {
    emit(AuthLoading());
    try {
      final user = await repository.register(
        event.username,
        event.email,
        event.password,
      );

      emit(RegisterSuccess(user));
    } catch (e) {
      if (e is DioException) {
        final message = e.response?.data["detail"] ??
            "Terjadi kesalahan server, silakan coba lagi.";
        emit(RegisterFailure(message));
      } else {
        emit(RegisterFailure("Terjadi kesalahan tidak diketahui"));
      }
    }
  }
}
