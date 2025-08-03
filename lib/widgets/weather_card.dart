import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Add this to pubspec.yaml: intl: ^0.18.0
import '../models/weather_model.dart';

class WeatherCard extends StatelessWidget {
  final Weather weather;

  const WeatherCard({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    // Dynamic current date and time
    final now = DateTime.now();
    final formattedDate = DateFormat('EEEE, MMMM d').format(now); // e.g., "Monday, June 23"

    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      clipBehavior: Clip.hardEdge, // Prevents visual overflow
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue[800]!, Colors.blue[400]!], // Matching the image's blue gradient
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        clipBehavior: Clip.hardEdge, // Additional clipping
        child: Padding(
          padding: const EdgeInsets.all(12.0), // Reduced from 16 to save vertical space
          child: ListView( // Simplified to ListView for robust scrolling
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(), // Smooth scrolling without bounce
            padding: EdgeInsets.zero, // Remove default padding to minimize height
            children: [
              // City and Date (Note: Country is not in model, so omitted or use dummy)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${weather.city}, ', // Dummy country; extend model to add 'country' from json['sys']['country']
                    style: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  const Icon(Icons.more_vert, color: Colors.white),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                formattedDate, // Dynamic date
                style: const TextStyle(fontSize: 14, color: Colors.white70),
              ),
              const SizedBox(height: 8), // Reduced from 16

              // Temperature and Icon
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    'http://openweathermap.org/img/wn/${weather.icon}@2x.png',
                    width: 80,
                    height: 80,
                  ),
                  const SizedBox(width: 12), // Reduced from 16
                  Text(
                    '${weather.temperature}°',
                    style: const TextStyle(fontSize: 64, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Center(
                child: Text(
                  weather.description,
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              const SizedBox(height: 8), // Reduced from 16

              // Stats (High/Low, Humidity, Wind, Rain) - Using dummies since not in model
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatColumn('High 26°\nLow 18°', Icons.arrow_upward), // Dummy; use json['main']['temp_max'] / ['temp_min']
                  _buildStatColumn('62%\nHumidity', Icons.water_drop), // Dummy; use json['main']['humidity']
                  _buildStatColumn('19 km/h\nWind', Icons.air), // Dummy; use json['wind']['speed']
                  _buildStatColumn('24%\nRain', Icons.umbrella), // Dummy; use json['rain'] or clouds for estimation
                ],
              ),
              const SizedBox(height: 12), // Reduced from 16

              // Hourly Forecast (Simulated; replace with real data from a forecast API)
              const Text(
                'Hourly Forecast',
                style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4), // Reduced from 8
              SizedBox(
                height: 80, // Fixed height to prevent vertical expansion
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(5, (index) => _buildHourlyItem('Now', 24, 'sunny')), // Example dummy data
                  ),
                ),
              ),
              const SizedBox(height: 12), // Reduced from 16

              // 7-Day Forecast (Now properly expanded to 7 days with dynamic dummies)
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(12), // Reduced from 16
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '7-Day Forecast',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4), // Reduced from 8
                    // Dynamically generate 7 days starting from today
                    ...List.generate(7, (index) {
                      final forecastDate = now.add(Duration(days: index));
                      final dayName = DateFormat('EEE').format(forecastDate); // e.g., "Mon", "Tue"
                      // Dummy data (cycle through examples; replace with real API data)
                      final temps = [28, 24, 26, 22, 25, 27, 23];
                      final descriptions = [
                        'Partly Cloudy',
                        'Showers',
                        'Sunny',
                        'Cloudy',
                        'Rainy',
                        'Clear',
                        'Windy'
                      ];
                      final icons = [
                        Icons.wb_sunny,
                        Icons.cloud,
                        Icons.wb_sunny,
                        Icons.cloud,
                        Icons.umbrella,
                        Icons.wb_sunny,
                        Icons.air
                      ];
                      return _buildWeeklyItem(
                        dayName,
                        temps[index],
                        descriptions[index],
                        icons[index],
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper for stats
  Widget _buildStatColumn(String label, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.white70, size: 20), // Reduced icon size slightly to save space
        const SizedBox(height: 2), // Reduced from 4
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 12), textAlign: TextAlign.center),
      ],
    );
  }

  // Helper for hourly forecast item
  Widget _buildHourlyItem(String time, int temp, String iconDescription) {
    return Padding(
      padding: const EdgeInsets.only(right: 12), // Reduced from 16
      child: Column(
        children: [
          Text(time, style: const TextStyle(color: Colors.white, fontSize: 12)), // Reduced font size
          const SizedBox(height: 2), // Reduced from 4
          Icon(Icons.wb_sunny, color: Colors.white, size: 20), // Reduced size; replace with dynamic
          const SizedBox(height: 2), // Reduced from 4
          Text('$temp°', style: const TextStyle(color: Colors.white, fontSize: 12)), // Reduced font size
        ],
      ),
    );
  }

  // Helper for weekly forecast item
  Widget _buildWeeklyItem(String day, int temp, String description, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2), // Reduced from 4
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: 50, child: Text(day, style: const TextStyle(fontSize: 12))),
          Icon(icon, size: 16), // Reduced size
          SizedBox(width: 50, child: Text('$temp°', style: const TextStyle(fontSize: 12), textAlign: TextAlign.center)),
          Expanded(child: Text(description, style: const TextStyle(fontSize: 12), textAlign: TextAlign.right)),
        ],
      ),
    );
  }
}