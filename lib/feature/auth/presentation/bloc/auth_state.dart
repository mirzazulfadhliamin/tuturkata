abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final String token;
  AuthSuccess(this.token);
}

class AuthFailure extends AuthState {
  final String message;
  AuthFailure(this.message);
}

class RegisterSuccess extends AuthState {
  final Map<String, dynamic> user;
  RegisterSuccess(this.user);
}

class RegisterFailure extends AuthState{
  final String message;
  RegisterFailure(this.message);
}
