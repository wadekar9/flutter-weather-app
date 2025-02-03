import 'package:flutter/material.dart';

class HourlyForecastCard extends StatelessWidget {

  final IconData icon;
  final String time;
  final String temperature;

  const HourlyForecastCard({super.key, required this.time, required this.temperature, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Container(
        width: 120,
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            Text(time,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Icon(icon, size: 32),
            SizedBox(height: 8),
            Text(temperature),
          ],
        ),
      ),
    );
  }
}