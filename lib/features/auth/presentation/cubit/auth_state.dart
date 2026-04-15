part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class RegisterLoadingState extends AuthState {}

class RegisterSuccessState extends AuthState {
  final RegisterResponseEntity registerResponse;

  const RegisterSuccessState(this.registerResponse);

  @override
  List<Object> get props => [registerResponse];
}

class RegisterFailureState extends AuthState {
  final String message;

  const RegisterFailureState(this.message);

  @override
  List<Object> get props => [message];
}

class LoginLoadingState extends AuthState {}

class LoginSuccessState extends AuthState {
  final LoginResponseEntity loginResponse;

  const LoginSuccessState(this.loginResponse);

  @override
  List<Object> get props => [loginResponse];
}

class LoginFailureState extends AuthState {
  final String message;

  const LoginFailureState(this.message);

  @override
  List<Object> get props => [message];
}

class LevelChangedState extends AuthState {
  final String selectedLevel;

  const LevelChangedState(this.selectedLevel);

  @override
  List<Object> get props => [selectedLevel];
}

class CountryCodeChangedState extends AuthState {
  @override
  List<Object> get props => [];
}

class LogoutLoadingState extends AuthState {}

class LogoutSuccessState extends AuthState {
  final LogoutResponseEntity logoutResponse;

  const LogoutSuccessState(this.logoutResponse);

  @override
  List<Object> get props => [logoutResponse];
}

class LogoutFailureState extends AuthState {
  final String message;

  const LogoutFailureState(this.message);

  @override
  List<Object> get props => [message];
}

class ProfileLoadingState extends AuthState {}

class ProfileSuccessState extends AuthState {
  final ProfileResponseEntity profileResponse;

  const ProfileSuccessState(this.profileResponse);

  @override
  List<Object> get props => [profileResponse];
}

class ProfileFailureState extends AuthState {
  final String message;

  const ProfileFailureState(this.message);

  @override
  List<Object> get props => [message];
}

class RefreshTokenLoadingState extends AuthState {}

class RefreshTokenSuccessState extends AuthState {
  final RefreshTokenResponseEntity response;

  const RefreshTokenSuccessState(this.response);

  @override
  List<Object> get props => [response];
}

class RefreshTokenFailureState extends AuthState {
  final String message;

  const RefreshTokenFailureState(this.message);

  @override
  List<Object> get props => [message];
}
