import 'package:dartz/dartz.dart';
import 'package:tasky_api/core/api/api.dart';
import 'package:tasky_api/core/di/di.dart';
import 'package:tasky_api/core/errors/failures.dart';
import 'package:tasky_api/core/mappers/refresh_token_response_mapper.dart';
import 'package:tasky_api/core/network/network_service.dart';
import 'package:tasky_api/features/auth/data/datasources/remote/refresh_token_remote_data_source.dart';
import 'package:tasky_api/features/auth/domain/entities/refresh_token_response_entity.dart';

import '../../../../../../core/api/end_points.dart';
import '../../../../../../core/cache/cache_helper.dart';
import '../../../models/refresh_token_response_dto.dart';

class RefreshTokenRemoteDataSourceImpl implements RefreshTokenRemoteDataSource {
  final API api;
  final NetworkService networkService;
  RefreshTokenRemoteDataSourceImpl({
    required this.api,
    required this.networkService,
  });

  @override
  Future<Either<Failure, RefreshTokenResponseEntity>> refreshToken() async {
    try {
      if (await networkService.isConnected()) {
        var refreshToken = getIt<CacheHelper>().getData(key: 'refreshToken');
        final response = await api.get(
          EndPoints.refreshToken,
          queryParameters: {'token': refreshToken},
        );
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          final profileResponse = RefreshTokenResponseDto.fromJson(
            response.data,
          ).toEntity();
          return Right(profileResponse);
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
