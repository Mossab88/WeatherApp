import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_clean_arch/domain/entities/weather.dart';
import 'package:weather_clean_arch/presentation/state/weather_notifier.dart';
import 'package:weather_clean_arch/presentation/widgets/weather_card.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(weatherNotifierProvider.notifier).loadLastCityAndFetch());
  }

  @override
  Widget build(BuildContext context) {
    final weatherState = ref.watch(weatherNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        labelText: 'Search by city',
                        border: OutlineInputBorder(),
                      ),
                      onSubmitted: (v) => ref.read(weatherNotifierProvider.notifier).fetch(v),
                    ),
                  ),
                  const SizedBox(width: 8),
                  FilledButton(
                    onPressed: () => ref.read(weatherNotifierProvider.notifier).fetch(_controller.text),
                    child: const Text('Search'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: weatherState.when(
                  data: (weather) {
                    if (weather == null) {
                      return const Center(child: Text('Search a city to see weather'));
                    }
                    return WeatherCard(weather: weather);
                  },
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (e, _) => Center(
                    child: Text(
                      e.toString().replaceFirst('Exception: ', ''),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}