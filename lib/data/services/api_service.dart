import 'package:dio/dio.dart';
import 'package:weather_clean_arch/core/env.dart';
import 'package:weather_clean_arch/core/failures.dart';

class ApiService {
  ApiService._internal()
      : _dio = Dio(
          BaseOptions(
            baseUrl: 'https://api.openweathermap.org/data/2.5',
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 10),
          ),
        );

  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;

  final Dio _dio;



  Future<Response> getCurrentWeather(String city) async {
    try {
      final res = await _dio.get(
        '/weather',
        queryParameters: {
          'q': city,
          'appid': Env.openWeatherApiKey,
          'units': 'metric',
        },
      );
      return res;
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        throw const NotFoundFailure('City not found');
      }
      throw NetworkFailure(e.message ?? 'Network error');
    } catch (e) {
      throw UnknownFailure(e.toString());
    }
  }

  Future<Response> getForecast(String city) async {
    try {
      final res = await _dio.get(
        '/forecast',
        queryParameters: {
          'q': city,
          'appid': Env.openWeatherApiKey,
          'units': 'metric',
        },
      );
      return res;
    } on DioException catch (e) {
      throw NetworkFailure(e.message ?? 'Network error');
    } catch (e) {
      throw UnknownFailure(e.toString());
    }
  }
}