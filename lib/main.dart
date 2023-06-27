import 'package:flutter/material.dart';
import 'package:web_server_location_tracker/screns/map_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
        ),
      ),
      debugShowCheckedModeBanner: false,
      title: 'GPSpeed',
      home: const MainMap(),
    );
  }
}
