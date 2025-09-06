import 'package:weather_clean_arch/domain/entities/weather.dart';

abstract class IWeatherRepository {
  Future<Weather> getWeatherByCity(String city);
  Future<List<Weather>> get3DayForecastByCity(String city);
}