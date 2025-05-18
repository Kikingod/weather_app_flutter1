import 'package:flutter/material.dart';

class AddInformation extends StatefulWidget {
  final int currentPressure;
  final double currentWind;
  final int currentHumidity;
  const AddInformation({
    super.key,
    required this.currentPressure,
    required this.currentWind,
    required this.currentHumidity,
  });

  @override
  State<AddInformation> createState() => _AddInformationState();
}

class _AddInformationState extends State<AddInformation> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Additional Information',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        Row(
          spacing: 40,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Info(
              icon: Icons.water_drop,
              text: 'Pressure',
              value: '${widget.currentPressure}',
            ),
            Info(
              icon: Icons.air,
              text: 'Windy',
              value: '${widget.currentWind}',
            ),
            Info(
              icon: Icons.umbrella_sharp,
              text: 'Humidity',
              value: '${widget.currentHumidity}',
            ),
          ],
        ),
      ],
    );
  }
}

class Info extends StatelessWidget {
  final IconData icon;
  final String text;
  final String value;
  const Info({
    super.key,
    required this.icon,
    required this.text,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 32),
        Text(text),
        Text(value, style: TextStyle(fontSize: 20)),
      ],
    );
  }
}
