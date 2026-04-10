import 'package:dio/dio.dart';

import 'ApiConstants.dart';

class DioHelper {
  static Dio dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 10),
    ),
  );
}
