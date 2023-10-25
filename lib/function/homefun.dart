import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weatherapplite/models/city.dart';
import 'package:weatherapplite/ui/weather_page.dart';


class weatherdata extends ChangeNotifier {
  weatherdata() {
   fetchWeatherDataByLocation();
  }
  MyModel? weather;
  Future<MyModel?> fetchweatherdata(String city) async {
    final Response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=135da4f8722b429bbb31fe9c977c253a&units=metric'));

    if (Response.statusCode == 200) {
      final jsonresponse = jsonDecode(Response.body);
      weather = MyModel.fromJson(jsonresponse);
      print(jsonresponse);
      //print(weather);
      notifyListeners();
      return weather;
    } else {
      notifyListeners();
      print(Response.statusCode);
      // throw Exception('failed to fetch the weather');
    }
  }

//   Future<Position> getloaction() async {
//     try {
//       LocationPermission permission;
//       permission = await Geolocator.checkPermission();
//       if (permission == LocationPermission.denied) {
//         permission = await Geolocator.requestPermission();
//         if (permission == LocationPermission.denied) {
//           print('Location permissions are denied');
//           notifyListeners();
//           return Future.error('Location permissions are denied');
//         }
//       }
//       if (permission == LocationPermission.deniedForever) {
//         // Permissions are denied forever, handle appropriately.
//         print(
//             'Location permissions are permanently denied, we cannot request permissions.');
//         notifyListeners();
//         return Future.error(
//             'Location permissions are permanently denied, we cannot request permissions.');
//       }
//       notifyListeners();
//       return await Geolocator.getCurrentPosition(
//           desiredAccuracy: LocationAccuracy.high);
//     } on LocationServiceDisabledException catch (e) {
//       print('$e');
//       notifyListeners();
//       return Future.error('Location  permissions$e.');
//     }
//   }
// }
Future<void> fetchWeatherDataByLocation() async {
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permission denied');
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final response = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?lat=${position.latitude}&lon=${position.longitude}&appid=135da4f8722b429bbb31fe9c977c253a&units=metric'));

      if (response.statusCode == 200) {
        final jsonresponse = jsonDecode(response.body);
        weather = MyModel.fromJson(jsonresponse);
        notifyListeners();
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (error) {
      print('Error fetching weather data: $error');
      throw Exception('Failed to fetch weather data: $error');
    }
  }
}

//  Future <Widget> weatherimage() async{
//     if();{

//     } 
// }
