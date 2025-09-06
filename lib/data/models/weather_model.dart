import 'package:weather_clean_arch/domain/entities/weather.dart';

class WeatherModel {
  final String city;
  final double temperature;
  final String description;
  final String condition;
  final String iconCode;

  WeatherModel({
    required this.city,
    required this.temperature,
    required this.description,
    required this.condition,
    required this.iconCode,
  });

  factory WeatherModel.fromCurrentJson(Map<String, dynamic> json) {
    return WeatherModel(
      city: json['name'] ?? '',
      temperature: ((json['main']?['temp'] ?? 0).toDouble()),
      description: (json['weather']?[0]?['description'] ?? '').toString(),
      condition: (json['weather']?[0]?['main'] ?? '').toString(),
      iconCode: (json['weather']?[0]?['icon'] ?? '').toString(),
    );
  }

  factory WeatherModel.fromForecastItem(Map<String, dynamic> json, String city) {
    return WeatherModel(
      city: city,
      temperature: ((json['main']?['temp'] ?? 0).toDouble()),
      description: (json['weather']?[0]?['description'] ?? '').toString(),
      condition: (json['weather']?[0]?['main'] ?? '').toString(),
      iconCode: (json['weather']?[0]?['icon'] ?? '').toString(),
    );
  }

  Weather toEntity() => Weather(
        city: city,
        temperature: temperature,
        description: description,
        condition: condition,
        iconCode: iconCode,
      );
}