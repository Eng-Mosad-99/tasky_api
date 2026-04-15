import 'package:dio/dio.dart';
import 'package:path/path.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:tasky_api/core/api/end_points.dart';
import 'package:tasky_api/core/cache/cache_helper.dart';
import 'package:tasky_api/core/di/di.dart';
import 'package:tasky_api/core/errors/failures.dart';

class API {
  final Dio _dio =
      Dio(
          BaseOptions(
            baseUrl: EndPoints.baseURL,
            responseType: ResponseType.json,
            sendTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 10),
          ),
        )
        ..interceptors.add(
          CustomDioLogger(
            requestHeader: true,
            requestBody: true,
            responseBody: true,
            error: true,
          ),
        );

  Future<Map<String, dynamic>> _header() async {
    final token = getIt<CacheHelper>().getData(key: 'accessToken') ?? '';

    // final AuthData? userData =
    // cachedUser == null ? null : AuthData.fromJson(cachedUser);
    return {
      'Authorization': 'Bearer $token',
      // 'User-Token': userData?.authenticationCode ?? '',
      // 'User-Id': userData?.id ?? -1,
    };
  }

  /// GET Method
  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: Options(headers: await _header()),
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      throw ServerFailure(_handleDioError(e as DioException));
    }
  }

  /// POST Method
  Future<Response> post(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.post(
        url,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: await _header()),
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      throw ServerFailure(_handleDioError(e as DioException));
    }
  }

  /// PUT Method
  Future<Response> put(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.put(
        url,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: await _header()),
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      throw ServerFailure(_handleDioError(e as DioException));
    }
  }

  /// DELETE Method
  Future<Response> delete(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.delete(
        url,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: await _header()),
        cancelToken: cancelToken,
      );
      return response;
    } catch (e) {
      throw ServerFailure(_handleDioError(e as DioException));
    }
  }

  /// File Upload Method
  Future<Response> uploadFile({required String filePath}) async {
    try {
      final formData = FormData.fromMap({
        'image': [
          await MultipartFile.fromFile(filePath, filename: basename(filePath)),
        ],
      });

      final response = await post(EndPoints.uploadImage, data: formData);

      return response;
    } catch (e) {
      throw ServerFailure(_handleDioError(e as DioException));
    }
  }

  /// Handles errors from Dio
  String _handleDioError(DioException e) {
    if (e.response != null) {
      final responseData = e.response?.data;
      return responseData['message'];
    } else if (e.message != null) {
      return e.message!;
    } else {
      return 'Unknown Error';
    }
  }
}

class CustomDioLogger extends PrettyDioLogger {
  final bool requestHeader, requestBody, responseBody, error, compact;
  final int maxWidth;
  CustomDioLogger({
    this.requestHeader = false,
    this.requestBody = false,
    this.responseBody = true,
    this.error = true,
    this.compact = true,
    this.maxWidth = 90,
  }) : super(
         requestHeader: requestHeader,
         requestBody: requestBody,
         responseBody: responseBody,
         error: error,
         compact: compact,
         maxWidth: maxWidth,
       );

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response != null) {
      logPrint('🔴 Response Data: ${err.response?.data}');
      logPrint('🔴 Status Code: ${err.response?.statusCode}');
      logPrint('🔴 Headers: ${err.response?.headers}');
    } else if (err.message != null) {
      logPrint('🔴 Error Message: ${err.message}');
    } else {
      logPrint('🔴 Error Details: ${err.error}');
    }
    super.onError(err, handler);
  }
}
