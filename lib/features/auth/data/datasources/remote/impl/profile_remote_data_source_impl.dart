import 'package:dartz/dartz.dart';
import 'package:tasky_api/core/api/api.dart';
import 'package:tasky_api/core/api/end_points.dart';
import 'package:tasky_api/core/errors/failures.dart';
import 'package:tasky_api/core/mappers/profile_response_mapper.dart';
import 'package:tasky_api/core/network/network_service.dart';

import '../../../../domain/entities/profile_response_entity.dart';
import '../../../models/profile_response_dto.dart';
import '../profile_remote_data_source.dart';

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final API api;
  final NetworkService networkService;
  ProfileRemoteDataSourceImpl({
    required this.api,
    required this.networkService,
  });
  @override
  Future<Either<Failure, ProfileResponseEntity>> getProfile() async {
    try {
      if (await networkService.isConnected()) {
        final response = await api.get(EndPoints.getProfile);
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          final profileResponse = ProfileResponseDto.fromJson(
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
