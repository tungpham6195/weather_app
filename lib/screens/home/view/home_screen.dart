import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cores/cores.dart';
import 'package:weather_app/locator/locator.dart';
import 'package:weather_app/screens/home/cubit/home_cubit.dart';
import 'package:weather_app/screens/screens.dart';

/// {@template home_screen}
/// The view of home screen.
/// {@endtemplate}
final class HomeScreen extends StatefulWidget {
  /// {@macro home_screen}
  @visibleForTesting
  const HomeScreen({super.key});

  /// Provide new instance of home screen.
  // coverage:ignore-start
  static Widget route() => BlocProvider(
        create: (context) => HomeCubit(
          locationRepository: locator.locationRepository,
          weatherRepository: locator.weatherRepository,
        )..loadCurrentWeather(),
        child: const HomeScreen(),
      ); // coverage:ignore-end

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeCubit get _cubit => context.read<HomeCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onSubmitted: (value) => _cubit.searchLocation(locationName: value),
          decoration: const InputDecoration(hintText: 'Find your location!'),
        ),
      ),
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state.status == DataLoadStatus.failure) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.errorMessage)));
            return;
          }
        },
        builder: (context, state) {
          if (state.status == DataLoadStatus.loading) {
            return const Center(child: CupertinoActivityIndicator());
          }
          if (state.status == DataLoadStatus.failure) {
            return const SizedBox.shrink();
          }
          final weather = state.weather!;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Column(
                children: [
                  Text(weather.time.toString()),
                  const SizedBox(height: 8),
                  Text('${weather.temperature}ºF'),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        WeatherDetailScreen.route(weather: weather),
                      );
                    },
                    child: const Text('View weather detail'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
