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
  bool _isSearching = false; // State for toggling search bar

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

  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
      if (!_isSearching) {
        _cityController.clear(); // Optional: Clear input when closing
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50], // Soft blue background for the body to match weather theme
      appBar: AppBar(
        title: _isSearching
            ? TextField(
                controller: _cityController,
                autofocus: true, // Auto-focus when opened
                onSubmitted: (_) => _fetchWeather(), // Trigger search on Enter/Done
                decoration: InputDecoration(
                  hintText: 'Enter city', // Changed to hint for better UX
                  hintStyle: TextStyle(color: Colors.white70),
                  border: InputBorder.none, // Clean look in AppBar
                  // No suffixIcon as per request (hidden when search is open)
                ),
                style: const TextStyle(color: Colors.white), // White text for visibility
              )
            : const Text(
                'Weather app',
                style: TextStyle(color: Colors.white), // White text for contrast
              ),
        backgroundColor: Colors.blue[800], // Deep blue background to match WeatherCard gradient
        elevation: 4, // Subtle shadow for a "proper" look
        centerTitle: false, // Left-aligned title/search for "text on the left side"
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search, color: Colors.white),
            onPressed: _toggleSearch, // Toggle search bar on/off
          ),
        ],

        // Optional: If you want a gradient background for the AppBar (uncomment below)
        // flexibleSpace: Container(
        //   decoration: BoxDecoration(
        //     gradient: LinearGradient(
        //       begin: Alignment.topCenter,
        //       end: Alignment.bottomCenter,
        //       colors: [Colors.blue[800]!, Colors.blue[400]!],
        //     ),
        //   ),
        // ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Expanded + Scrollable wrapper for full height and scrolling
            Expanded(
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(), // Smooth scrolling
                child: _isLoading
                    ? const LoadingWidget()
                    : _weather != null
                        ? WeatherCard(weather: _weather!)
                        : Container(), // Or replace with a message like Text('No weather data available')
              ),
            ),
          ],
        ),
      ),
    );
  }
}