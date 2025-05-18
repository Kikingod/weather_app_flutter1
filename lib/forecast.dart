import 'package:flutter/material.dart';

class Myforecast extends StatefulWidget {
  final List<Map<String, dynamic>> listWeathers;
  const Myforecast({super.key, required this.listWeathers});

  @override
  State<Myforecast> createState() => _MyforecastState();
}

class _MyforecastState extends State<Myforecast> {
  //here
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Weather Forecast",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              WeatherCard(
                time:
                    '${widget.listWeathers[0]['dt_txt'].split(" ")[1].substring(0, 5)}',
                icon:
                    widget.listWeathers[0]['weather'][0]['main'] == 'Clouds' ||
                            widget.listWeathers[0]['weather'][0]['main'] ==
                                'Rain'
                        ? Icons.cloud
                        : Icons.sunny,
                stupen:
                    '${(widget.listWeathers[0]['main']['temp'] - 273.15).toStringAsFixed(2)} C',
              ),
              WeatherCard(
                time:
                    '${widget.listWeathers[1]['dt_txt'].split(" ")[1].substring(0, 5)}',
                icon:
                    widget.listWeathers[1]['weather'][0]['main'] == 'Clouds' ||
                            widget.listWeathers[1]['weather'][0]['main'] ==
                                'Rain'
                        ? Icons.cloud
                        : Icons.sunny,
                stupen:
                    '${(widget.listWeathers[1]['main']['temp'] - 273.15).toStringAsFixed(2)} C',
              ),
              WeatherCard(
                time:
                    '${widget.listWeathers[2]['dt_txt'].split(" ")[1].substring(0, 5)}',
                icon:
                    widget.listWeathers[2]['weather'][0]['main'] == 'Clouds' ||
                            widget.listWeathers[2]['weather'][0]['main'] ==
                                'Rain'
                        ? Icons.cloud
                        : Icons.sunny,
                stupen:
                    '${(widget.listWeathers[2]['main']['temp'] - 273.15).toStringAsFixed(2)} C',
              ),
              WeatherCard(
                time:
                    '${widget.listWeathers[3]['dt_txt'].split(" ")[1].substring(0, 5)}',
                icon:
                    widget.listWeathers[3]['weather'][0]['main'] == 'Clouds' ||
                            widget.listWeathers[3]['weather'][0]['main'] ==
                                'Rain'
                        ? Icons.cloud
                        : Icons.sunny,
                stupen:
                    '${(widget.listWeathers[3]['main']['temp'] - 273.15).toStringAsFixed(2)} C',
              ),
              WeatherCard(
                time:
                    '${widget.listWeathers[4]['dt_txt'].split(" ")[1].substring(0, 5)}',
                icon:
                    widget.listWeathers[4]['weather'][0]['main'] == 'Clouds' ||
                            widget.listWeathers[4]['weather'][0]['main'] ==
                                'Rain'
                        ? Icons.cloud
                        : Icons.sunny,
                stupen:
                    '${(widget.listWeathers[4]['main']['temp'] - 273.15).toStringAsFixed(2)} C',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class WeatherCard extends StatelessWidget {
  final String time;
  final IconData icon;
  final String stupen;
  const WeatherCard({
    super.key,
    required this.time,
    required this.icon,
    required this.stupen,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Card(
        elevation: 10,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(time, style: TextStyle(fontSize: 16)),
              SizedBox(height: 8),
              Icon(icon, size: 32),
              SizedBox(height: 8),
              Text(stupen, style: TextStyle(fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }
}
