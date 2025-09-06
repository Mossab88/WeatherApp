import 'package:weather_clean_arch/domain/entities/weather.dart';
import 'package:weather_clean_arch/domain/repositories/weather_repository.dart';

class GetWeatherByCity {
  final IWeatherRepository repository;

  const GetWeatherByCity(this.repository);

  Future<Weather> call(String city) async {
    final current = await repository.getWeatherByCity(city);
    try {
      final forecast = await repository.get3DayForecastByCity(city);
      return Weather(
        city: current.city,
        temperature: current.temperature,
        description: current.description,
        condition: current.condition,
        iconCode: current.iconCode,
        simple3DayForecast: forecast,
      );
    } catch (_) {
      return current;
    }
  }
}