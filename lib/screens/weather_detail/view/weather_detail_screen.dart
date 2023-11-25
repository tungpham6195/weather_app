import 'package:flutter/material.dart';
import 'package:weather_app/repositories/repositories.dart';

/// {@template weather_detail_screen}
/// The view of weather detail screen.
/// {@endtemplate}
final class WeatherDetailScreen extends StatelessWidget {
  /// {@macro weather_detail_screen}
  @visibleForTesting
  const WeatherDetailScreen({required this.weather, super.key});

  /// Returns new route of weather detail screen.
  // coverage:ignore-start
  static Route<dynamic> route({required Weather weather}) => MaterialPageRoute(
        builder: (context) => WeatherDetailScreen(weather: weather),
        settings: const RouteSettings(name: '/weather-detail'),
      ); // coverage:ignore-end

  /// The information of current weather.
  final Weather weather;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Weather Detail')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(weather.time.toString()),
              const SizedBox(height: 8),
              Text('${weather.temperature}ºF'),
              const SizedBox(height: 16),
              const Text(
                'Forecasts',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              ListView.separated(
                padding: const EdgeInsets.only(top: 8),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final forecast = weather.forecasts[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(forecast.time.toString()),
                      const SizedBox(height: 4),
                      Text(forecast.summary),
                    ],
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(height: 4),
                itemCount: weather.forecasts.length,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
