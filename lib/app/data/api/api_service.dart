import 'package:dio/dio.dart';
enum MethodType { post }

class ApiCall {
  final Dio _dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
    contentType: Headers.formUrlEncodedContentType,
  ));

  Future<void> fetchApiData({
    required String endPoint,
    required MethodType method,
    Map<String, dynamic>? requestData,
    required Function(dynamic response, String message) successCallback,
    required Function(String message, int? statusCode) failureCallback,
  }) async {
    try {
      late Response response;

      switch (method) {
        case MethodType.post:
          response = await _dio.post(endPoint, data: FormData.fromMap(requestData ?? {}));
          break;
      }

      if (response.statusCode == 200 && response.data['status'] == true) {
        successCallback(response.data, response.data['message'] ?? 'Success');
      } else {
        failureCallback(response.data['message'] ?? 'Something went wrong', response.statusCode);
      }
    } catch (e) {
      if (e is DioException) {
        failureCallback(e.response?.data['message'] ?? e.message, e.response?.statusCode);
      } else {
        failureCallback("Unexpected error: $e", null);
      }
    }
  }
}
