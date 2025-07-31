import 'package:flutter/material.dart';
import '../models/weather_model.dart';

class WeatherDetailScreen extends StatelessWidget {
  final Weather weather;

  const WeatherDetailScreen({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${weather.cityName} Weather Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  weather.cityName,
                  style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Text(
                  '${weather.description}',
                  style: const TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
                ),
                const SizedBox(height: 16),
                Text('Temperature: ${weather.temperature}°C', style: const TextStyle(fontSize: 18)),
                Text('Humidity: ${weather.humidity}%', style: const TextStyle(fontSize: 18)),
                Text('Wind Speed: ${weather.windSpeed} m/s', style: const TextStyle(fontSize: 18)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
