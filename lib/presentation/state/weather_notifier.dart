import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_clean_arch/data/repositories/weather_repository_impl.dart';
import 'package:weather_clean_arch/data/services/api_service.dart';
import 'package:weather_clean_arch/domain/entities/weather.dart';
import 'package:weather_clean_arch/domain/usecases/get_weather_by_city.dart';

final apiServiceProvider = Provider<ApiService>((ref) => ApiService());
final repositoryProvider = Provider<WeatherRepositoryImpl>((ref) => WeatherRepositoryImpl(ref.read(apiServiceProvider)));
final getWeatherUseCaseProvider = Provider<GetWeatherByCity>((ref) => GetWeatherByCity(ref.read(repositoryProvider)));

final lastCityProvider = StateProvider<String?>((_) => null);

class WeatherNotifier extends StateNotifier<AsyncValue<Weather?>> {
  WeatherNotifier(this._getWeather) : super(const AsyncValue.data(null));

  final GetWeatherByCity _getWeather;

  Future<void> loadLastCityAndFetch() async {
    final prefs = await SharedPreferences.getInstance();
    final last = prefs.getString('last_city');
    if (last != null && last.isNotEmpty) {
      await fetch(last, save: false);
    }
  }

  Future<void> fetch(String city, {bool save = true}) async {
    if (city.trim().isEmpty) return;
    state = const AsyncValue.loading();
    try {
      final result = await _getWeather(city.trim());
      state = AsyncValue.data(result);
      if (save) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('last_city', city.trim());
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final weatherNotifierProvider = StateNotifierProvider<WeatherNotifier, AsyncValue<Weather?>>(
  (ref) => WeatherNotifier(ref.read(getWeatherUseCaseProvider)),
);