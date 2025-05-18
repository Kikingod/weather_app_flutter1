import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:weather_app/forecast.dart';
import 'package:weather_app/add_information.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_dotenv/flutter_dotenv.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreen();
}

class _WeatherScreen extends State<WeatherScreen> {
  double temp = 0.0;
  bool loading = true;
  late Future<Map<String, dynamic>> weather;

  Future<Map<String, dynamic>> getCurrentWeather() async {
    final cityName = 'Prague';
    final apiKey = dotenv.env['WEATHER_API_KEY'] ?? '';

    try {
      setState(() {
        loading = true;
      });
      final res = await http.get(
        Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?q=$cityName,cz&APPID=$apiKey',
        ),
      );
      final data = jsonDecode(res.body);
      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  void initState() {
    super.initState();
    weather = getCurrentWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: const Text(
            'Weather App',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        actions: [
          IconButton(
            // or Inkwell or GestureDetector
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                weather = getCurrentWeather();
              });
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: weather,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator.adaptive());
          }
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          final data = snapshot.data!;
          final currentTemp = data['list'][0]['main']['temp'];
          final currentSky = data['list'][0]['weather'][0]['main'];
          final currentPressure = data['list'][0]['main']['pressure'];
          final currentWind = data['list'][0]['wind']['speed'];
          final currentHumidity = data['list'][0]['main']['humidity'];

          List<Map<String, dynamic>> weatherDays = [];
          for (int i = 1; i < 6; i++) {
            weatherDays.add(data['list'][i]);
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // main kart
                  SizedBox(
                    width: double.infinity,
                    child: Card(
                      elevation: 50,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Text(
                              '${(currentTemp - 273.15).toStringAsFixed(2)} C',

                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Icon(
                              currentSky == 'Clouds' || currentSky == 'Rain'
                                  ? Icons.cloud
                                  : Icons.sunny,
                              size: 64,
                            ),
                            const SizedBox(height: 16),
                            Text(currentSky, style: TextStyle(fontSize: 20)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Myforecast(listWeathers: weatherDays),

                  const SizedBox(height: 20),
                  //additioanl information
                  AddInformation(
                    currentPressure: currentPressure,
                    currentWind: currentWind,
                    currentHumidity: currentHumidity,
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
