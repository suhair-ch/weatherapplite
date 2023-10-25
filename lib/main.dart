import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapplite/function/homefun.dart';
import 'package:weatherapplite/ui/weather_page.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => weatherdata(),
    child: MyApp(),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return 
      MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'wetaher app ',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: WeatherApp(),
    );
  }
}
