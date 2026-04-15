
import 'package:dartz/dartz.dart';
import 'package:tasky_api/core/api/api.dart';
import 'package:tasky_api/core/api/end_points.dart';
import 'package:tasky_api/core/errors/failures.dart';
import 'package:tasky_api/core/mappers/register_response_mapper.dart';
import 'package:tasky_api/core/network/network_service.dart';
import 'package:tasky_api/features/auth/data/datasources/remote/register_remote_data_source.dart';
import 'package:tasky_api/features/auth/data/models/register_response_dto.dart';
import 'package:tasky_api/features/auth/domain/entities/register_response_entity.dart';
import 'package:tasky_api/features/auth/requests/register_request_body.dart';

class RegisterRemoteDataSourceImpl implements RegisterRemoteDataSource {
  final API api;
  final NetworkService networkService;
  RegisterRemoteDataSourceImpl({
    required this.api,
    required this.networkService,
  });
  @override
  Future<Either<Failure, RegisterResponseEntity>> register(
    RegisterRequestBody request,
  ) async {
    try {
      if (await networkService.isConnected()) {
        final response = await api.post(
          EndPoints.signup,
          data: request.toJson(),
        );
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          final registerResponse = RegisterResponseDto.fromJson(
            response.data,
          ).toEntity();
          return Right(registerResponse);
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
