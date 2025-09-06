class Weather {
  final String city;
  final double temperature;
  final String description;
  final String condition;
  final String iconCode;
  final List<Weather>? simple3DayForecast;

  const Weather({
    required this.city,
    required this.temperature,
    required this.description,
    required this.condition,
    required this.iconCode,
    this.simple3DayForecast,
  });
}