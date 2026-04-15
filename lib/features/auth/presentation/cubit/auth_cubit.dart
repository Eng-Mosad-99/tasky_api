import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:country_list_pick/country_list_pick.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky_api/core/cache/cache_helper.dart';
import 'package:tasky_api/core/di/di.dart';
import 'package:tasky_api/features/auth/domain/entities/refresh_token_response_entity.dart';
import 'package:tasky_api/features/auth/domain/usecases/login_use_case.dart';
import 'package:tasky_api/features/auth/domain/usecases/refresh_token_use_case.dart';
import 'package:tasky_api/features/auth/domain/usecases/register_use_case.dart';

import '../../domain/entities/login_response_entity.dart';
import '../../domain/entities/logout_response_entity.dart';
import '../../domain/entities/profile_response_entity.dart';
import '../../domain/entities/register_response_entity.dart';
import '../../domain/usecases/logout_use_case.dart';
import '../../domain/usecases/profile_use_case.dart';
import '../../requests/login_request_body.dart';
import '../../requests/register_request_body.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(
    this.registerUseCase,
    this.loginUseCase,
    this.logoutUseCase,
    this.profileUseCase,
    this.refreshTokenUseCase,
  ) : super(AuthInitial());

  final RegisterUseCase registerUseCase;
  final LoginUseCase loginUseCase;
  final LogoutUseCase logoutUseCase;
  final ProfileUseCase profileUseCase;
  final RefreshTokenUseCase refreshTokenUseCase;

  final TextEditingController displayNameController = TextEditingController(
    text: 'John Doe',
  );
  final TextEditingController passwordController = TextEditingController(
    text: '******',
  );
  final TextEditingController phoneController = TextEditingController(
    text: '1234567890',
  );
  final TextEditingController addressController = TextEditingController(
    text: '123 Main Street',
  );
  final TextEditingController experienceYearsController = TextEditingController(
    text: '5',
  );

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final List<String> levels = ['fresh', 'junior', 'midLevel', 'senior'];
  String? selectedLevel;

  changeLevel(String? newValue) {
    selectedLevel = newValue;
    log('selectedLevel: $selectedLevel');
    emit(LevelChangedState(selectedLevel!));
  }

  String selectedCountryCode = '+20';
  changeCountryCode(CountryCode code) {
    selectedCountryCode = code.dialCode!;
    emit(CountryCodeChangedState());
  }

  Future<void> register() async {
    emit(RegisterLoadingState());
    if (formKey.currentState!.validate()) {
      final result = await registerUseCase.call(
        RegisterRequestBody(
          displayName: displayNameController.text,
          phone: selectedCountryCode + phoneController.text,
          password: passwordController.text,
          address: addressController.text,
          experienceYears: int.parse(experienceYearsController.text),
          level: selectedLevel!,
        ),
      );
      result.fold(
        (failure) => emit(RegisterFailureState(failure.errorMessage)),
        (registerResponse) => emit(RegisterSuccessState(registerResponse)),
      );
    }
  }

  Future<void> login(String phone, String password) async {
    emit(LoginLoadingState());
    if (formKey.currentState!.validate()) {
      final result = await loginUseCase.call(
        LoginRequestBody(
          phone: selectedCountryCode + phone,
          password: password,
        ),
      );
      result.fold(
        (failure) => emit(LoginFailureState(failure.errorMessage)),
        (loginResponse) => emit(LoginSuccessState(loginResponse)),
      );
    }
  }

  void logout() async {
    emit(LogoutLoadingState());
    final result = await logoutUseCase.call();
    result.fold(
      (failure) => emit(LogoutFailureState(failure.errorMessage)),
      (logoutResponse) => emit(LogoutSuccessState(logoutResponse)),
    );
  }

  void getProfile() async {
    emit(ProfileLoadingState());
    final result = await profileUseCase.call();
    result.fold(
      (failure) => emit(ProfileFailureState(failure.errorMessage)),
      (profileResponse) => emit(ProfileSuccessState(profileResponse)),
    );
  }

  void refreshToken() async {
    emit(RefreshTokenLoadingState());
    final result = await refreshTokenUseCase.call();
    result.fold(
      (failure) => emit(RefreshTokenFailureState(failure.errorMessage)),
      (response) {
        getIt<CacheHelper>()
            .saveData(key: 'accessToken', value: response.accessToken)
            .then((value) {
              log('Access token saved successfully');
            });
        emit(RefreshTokenSuccessState(response));
      },
    );
  }
}
