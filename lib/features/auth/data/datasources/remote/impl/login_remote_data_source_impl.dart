import 'package:dartz/dartz.dart';
import 'package:tasky_api/core/api/api.dart';
import 'package:tasky_api/core/api/end_points.dart';
import 'package:tasky_api/core/errors/failures.dart';
import 'package:tasky_api/core/mappers/login_response_mapper.dart';
import 'package:tasky_api/features/auth/data/datasources/remote/login_remote_data_source.dart';
import 'package:tasky_api/features/auth/domain/entities/login_response_entity.dart';
import 'package:tasky_api/features/auth/requests/login_request_body.dart';

import '../../../../../../core/network/network_service.dart';
import '../../../models/login_response_dto.dart';

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource{
  final API api;
  final NetworkService networkService;
  LoginRemoteDataSourceImpl({
    required this.api,
    required this.networkService,
  });
  @override
  Future<Either<Failure, LoginResponseEntity>> login(LoginRequestBody request) async {
  try {
    if (await networkService.isConnected()) {
      final response = await api.post(
        EndPoints.signin,
        data: request.toJson(),
      );
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        final loginResponse = LoginResponseDto.fromJson(
          response.data,
        ).toEntity();
        return Right(loginResponse);
      } else {
        return Left(
          ServerFailure(response.data['message'] ?? 'An error occurred'),
        );
      }
    } else {
      return Left(ServerFailure('No Internet Connection'));
    } 
  } catch (e) {
    print(e); 
    if (e is ServerFailure) {
      return Left(e);
    }
    return Left(ServerFailure(e.toString()));
  }
  }
}