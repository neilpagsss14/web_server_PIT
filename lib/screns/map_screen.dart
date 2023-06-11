import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'package:web_server_location_tracker/widgets/text_widget.dart';

import '../widgets/drawer_widget.dart';

class MainMap extends StatelessWidget {
  const MainMap({super.key});
  final String esp32Url = 'http://192.168.71.211';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: Colors.lightBlueAccent,
            onPressed: () {
              sendRequestToESP32();
            },
            child: const Icon(Icons.connect_without_contact),
          ),
          const SizedBox(
            height: 15,
          ),
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
        title: TextBold(
            text: 'GPSpeed Web Server', fontSize: 25, color: Colors.black),
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
    try {
      final response = await http.get(Uri.parse(esp32Url));
      if (response.statusCode == 200) {
        print('Response from ESP32: ${response.body}');
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error sending request to ESP32: $e');
    }
  }
}
