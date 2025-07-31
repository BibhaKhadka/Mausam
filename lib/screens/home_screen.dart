import 'package:flutter/material.dart';
import '../services/weather_service.dart';
import '../services/firestore_service.dart';
import '../models/weather_model.dart';
import '../widgets/weather_card.dart';
import '../widgets/loading_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final WeatherService _weatherService = WeatherService();
  final FirestoreService _firestoreService = FirestoreService();

  Weather? _weather;
  final TextEditingController _cityController = TextEditingController();
  bool _isLoading = false;

  Future<void> _fetchWeather() async {
    setState(() => _isLoading = true);
    final weather = await _weatherService.fetchWeather(_cityController.text);
    setState(() {
      _weather = weather;
      _isLoading = false;
    });
    if (weather != null) {
      await _firestoreService.saveCity(weather.city);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Weather Dashboard')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _cityController,
              decoration: InputDecoration(
                labelText: 'Enter city',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: _fetchWeather,
                ),
              ),
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const LoadingWidget()
                : _weather != null
                    ? WeatherCard(weather: _weather!)
                    : Container(),
          ],
        ),
      ),
    );
  }
}
