import 'package:flutter/material.dart';
import '../models/weather_model.dart';

class WeatherCard extends StatelessWidget {
  final Weather weather;

  const WeatherCard({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(weather.city, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text('${weather.temperature}°C', style: TextStyle(fontSize: 40)),
            Text(weather.description),
            Image.network('http://openweathermap.org/img/wn/${weather.icon}@2x.png'),
          ],
        ),
      ),
    );
  }
}
