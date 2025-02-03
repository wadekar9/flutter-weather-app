import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather_app/detail_item.dart';
import 'package:weather_app/hourly_forecast_item.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/secrets.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  double temperature = 0;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getCurrentWeather();
  }

  Future<Map<String, dynamic>> getCurrentWeather() async {
    try {
      // setState(() {
      //   isLoading = true;
      // });

      String cityName = 'London,uk';
      final response = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=$openWeatherAPIKey'));
      final data = jsonDecode(response.body);

      if (data['cod'] != '200') {
        throw data['message'] ? data['message'] : "An Unexpented error occured";
      }
      return data;
      // print(data['list'][0]['main']);
      // temperature = data['list'][0]['main']['temp'];
    } catch (e) {
      throw e.toString();
    } finally {
      // setState(() {
      //   isLoading = false;
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App',
            style: TextStyle(fontWeight: FontWeight.w500)),
        centerTitle: true,
        actions: [
          // GestureDetector(
          //   onTap: () => {
          //     print("ON TAP CLICK")
          //   },
          //   child: const Icon(Icons.refresh),
          // )
          IconButton(
              onPressed: () {
                print("OP44");
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: FutureBuilder(
          future: getCurrentWeather(),
          builder: (context, snapshot) {
            // print("SNAPSHOT $snapshot");
            // print("runtimeType ${snapshot.runtimeType}");

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator.adaptive());
            }

            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }

            final data = snapshot.data!;
            final currentWeatherData = data['list'][0];
            final currentWeatherTemp = currentWeatherData['main']['temp'];
            final currentSky =
                currentWeatherData['weather'][0]['main'] as String;
            final currentAdditionalDetails =
                currentWeatherData['main'] as Map<String, dynamic>;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // main container
                  SizedBox(
                    width: double.infinity,
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: -10),
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Text(
                                  '${currentWeatherTemp} K',
                                  style: const TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 16),
                                Icon(
                                    currentSky == 'Cloud' ||
                                            currentSky == 'Rain'
                                        ? Icons.cloud
                                        : Icons.sunny,
                                    size: 60),
                                const SizedBox(height: 16),
                                Text(
                                  currentSky,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // weather forecase cards
                  const SizedBox(height: 20),

                  const Text("Hourly Forecast",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),

                  const SizedBox(height: 20),

                  // SingleChildScrollView(
                  //   scrollDirection: Axis.horizontal,
                  //   child: Row(
                  //     children: [
                  //       for (int i = 0; i < 20; i++)
                  //         HourlyForecastCard(
                  //           time: '${data['list'][i + 1]['dt']}',
                  //           temperature:
                  //               '${data['list'][i + 1]['main']['temp']}',
                  //           icon: (data['list'][i + 1]['weather'][0]['main'] ==
                  //                       'Rain' ||
                  //                   data['list'][i + 1]['weather'][0]['main'] ==
                  //                       'Clouds')
                  //               ? Icons.cloud
                  //               : Icons.sunny,
                  //         ),
                  //     ],
                  //   ),
                  // ),

                  ListView.builder(itemBuilder: itemBuilder),

                  const SizedBox(height: 20),
                  const Text("Additional Information",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      DetailItem(
                        icon: Icons.water_drop,
                        label: "Humidity",
                        value: currentAdditionalDetails['humidity'].toString(),
                      ),
                      DetailItem(
                        icon: Icons.air,
                        label: "Wind Speed",
                        value: '${currentWeatherData['wind']['speed']}',
                      ),
                      DetailItem(
                          icon: Icons.beach_access,
                          label: "Pressure",
                          value:
                              currentAdditionalDetails['pressure'].toString()),
                    ],
                  )
                ],
              ),
            );
          }),
    );
  }
}
