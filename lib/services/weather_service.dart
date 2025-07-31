import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';

class WeatherService {
  static const apiKey = 'b0ded1f7fb0637f55d35bf359eaeaf66'; // Your actual API key
  static const baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

  Future<Weather?> fetchWeather(String city) async {
    final url = Uri.parse('$baseUrl?q=$city&appid=$apiKey&units=metric');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return Weather.fromJson(json.decode(response.body));
    }
    return null;
  }
}
