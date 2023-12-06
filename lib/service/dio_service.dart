import 'package:escribo_ebook/interfaces/client_http_interface.dart';
import 'package:dio/dio.dart';

class DioService implements IClientHttp {
  final Dio dio;
  DioService({required this.dio});
  @override
  Future<Map<String, dynamic>> get(String url) async {
    final response = await dio.get(url);
    return response.data;
  }
}
