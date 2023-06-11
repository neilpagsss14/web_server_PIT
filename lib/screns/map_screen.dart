import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;

import '../widgets/drawer_widget.dart';

class MainMap extends StatelessWidget {
  const MainMap({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: Colors.lightBlueAccent,
            onPressed: () {},
            child: const Icon(Icons.send_to_mobile),
          ),
          const SizedBox(
            height: 15,
          ),
          FloatingActionButton(
            backgroundColor: Colors.lightBlueAccent,
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const MainMap()));
            },
            child: const Icon(Icons.refresh),
          ),
        ],
      ),
      drawer: const Drawer(
        child: DrawerWidget(),
      ),
      appBar: AppBar(
        title: const Text(
          'LOCATION TRACKER WEB SERVER',
          style: TextStyle(
              fontSize: 25,
              letterSpacing: 5,
              fontWeight: FontWeight.w900,
              color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: FlutterMap(
            options: MapOptions(
              center: LatLng(8.477217, 124.645920),
              zoom: 15.0,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
              ),
            ],
          )),
    );
  }

  Future<void> sendRequestToESP32() async {
    const url =
        'http://esp32-ip-address'; // Replace with the IP address of your ESP32
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // Request successful, handle the response
      print(response.body);
    } else {
      // Request failed, handle the error
      print('Request failed with status: ${response.statusCode}');
    }
  }
}
