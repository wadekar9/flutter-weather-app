import 'package:flutter/material.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Weather App',
          style: TextStyle(
            fontWeight: FontWeight.w500
          )
        ),
        centerTitle: true,
        actions: [
          // GestureDetector(
          //   onTap: () => {
          //     print("ON TAP CLICK")
          //   },
          //   child: const Icon(Icons.refresh),
          // )
          IconButton(onPressed: () {
            print("OP44");
          }, icon: Icon(Icons.refresh))
        ],
      ),

      body: Column(
        children: [
          // main container
          const Placeholder(
            fallbackHeight: 250,
            // child: const Text('JAY MAHAKAL'),
          ),

          // weather forecase cards
          const SizedBox(height: 20),
          const Placeholder(
            fallbackHeight: 150,
          ),
          // additional information
          const SizedBox(height: 20),
          const Placeholder(
            fallbackHeight: 150,
          )
        ],
      ),
    );
  }
}