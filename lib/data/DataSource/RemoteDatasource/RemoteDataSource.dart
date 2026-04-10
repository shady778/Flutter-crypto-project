import 'package:dio/dio.dart';
import 'package:first_flutter_project/core/Network/ApiConstants.dart';

import '../../../core/Network/DioHelper.dart';

class RemoteDataSource {

  Future<List<dynamic>> getRawCoinsData([List<String>? symbols]) async {
    try {
      final response = await DioHelper.dio.get(
        ApiConstants.ticker24h,
        queryParameters: symbols != null && symbols.isNotEmpty
            ? {
                'symbols': '[${symbols.map((s) => '"$s"').join(',')}]',
              }
            : null,
      );
      return response.data is List ? response.data : [response.data];
    } catch (e) {
      rethrow;
    }
  }
}
