import 'package:weather_clean_arch/core/failures.dart';
import 'package:weather_clean_arch/data/models/weather_model.dart';
import 'package:weather_clean_arch/data/services/api_service.dart';
import 'package:weather_clean_arch/domain/entities/weather.dart';
import 'package:weather_clean_arch/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl implements IWeatherRepository {
  final ApiService _api;

  WeatherRepositoryImpl(this._api);

  @override
  Future<Weather> getWeatherByCity(String city) async {
    final res = await _api.getCurrentWeather(city);
    final data = res.data as Map<String, dynamic>;
    final model = WeatherModel.fromCurrentJson(data);
    return model.toEntity();
  }

  @override
  Future<List<Weather>> get3DayForecastByCity(String city) async {
    final res = await _api.getForecast(city);
    final data = res.data as Map<String, dynamic>;
    final list = (data['list'] as List).cast<Map<String, dynamic>>();

    final byDay = <String, Map<String, dynamic>>{};
    for (final item in list) {
      final dtTxt = item['dt_txt']?.toString() ?? '';
      if (dtTxt.contains('12:00:00')) {
        final date = dtTxt.split(' ').first;
        byDay[date] = item;
      }
    }

    final selected = byDay.entries.take(3).map((e) => e.value).toList();

    return selected
        .map((j) => WeatherModel.fromForecastItem(j, data['city']?['name'] ?? city).toEntity())
        .toList();
  }
}