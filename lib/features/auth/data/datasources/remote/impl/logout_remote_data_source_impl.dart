import 'package:dartz/dartz.dart';
import 'package:tasky_api/core/api/api.dart';
import 'package:tasky_api/core/api/end_points.dart';

import 'package:tasky_api/core/errors/failures.dart';
import 'package:tasky_api/core/mappers/logout_response_mapper.dart';
import 'package:tasky_api/core/network/network_service.dart';
import 'package:tasky_api/features/auth/data/models/logout_response_dto.dart';

import 'package:tasky_api/features/auth/domain/entities/logout_response_entity.dart';

import '../logout_remote_data_source.dart';

class LogoutRemoteDataSourceImpl implements LogoutRemoteDataSource{
  final API api;
  final NetworkService networkService;
  LogoutRemoteDataSourceImpl({
    required this.api,
    required this.networkService,
  });
  @override
  Future<Either<Failure, LogoutResponseEntity>> logout() async {
    try {
      if (await networkService.isConnected()) {
        final response = await api.post(
          EndPoints.logout,
        
        );
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          final logoutResponse = LogoutResponseDto.fromJson(
            response.data,
          ).toEntity();
          return Right(logoutResponse);
        } else {
          return Left(
            ServerFailure(response.data['message'] ?? 'An error occurred'),
          );
        }
      } else {
        return Left(ServerFailure('No Internet Connection'));
      }
    } catch (e) {
      if (e is ServerFailure) {
        return Left(e);
      }
      return Left(ServerFailure(e.toString()));
    }
  }
}