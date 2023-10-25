import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:weatherapplite/controller/homefun.dart';
import 'package:weatherapplite/function/homefun.dart';
import 'package:weatherapplite/models/city.dart';
import 'package:weatherapplite/models/constanst_colors.dart';
import 'package:weatherapplite/models/weathericon.dart';

class WelcomePage extends StatefulWidget {
  WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final placecontroller = TextEditingController();
  MyModel? weather;

  constaant myConstant = constaant();

  @override
  Widget build(BuildContext context) {
    String town = '';
    Size size = MediaQuery.of(context).size;
    return Consumer<weatherdata>(
        builder: (context, value, child) => Scaffold(
              appBar: AppBar(
                // title: Text('welcome'),
                flexibleSpace: TextFormField(
                  onChanged: (value) {
                    town = value;
                    print(town);
                  },
                  // onTap: () => weatherdata().fetchweatherdata(town),
                  controller: placecontroller,
                  decoration: InputDecoration(
                    labelText: 'Enter Place',
                    border: OutlineInputBorder(),
                  ),
                ),
                actions: [
                  IconButton(
                      //                   onPressed: () {
                      //   value.fetchweatherdata(town).then((weatherData) {
                      //     setState(() {
                      //       weather = weatherData;
                      //     });
                      //   }).catchError((error) {
                      //     print('Error fetching weather data: $error');
                      //   });
                      // },
                      onPressed: () => value.fetchweatherdata(town),
                      icon: Icon(Icons.search))
                ],
              ),

              // backgroundColor: myConstant.primarycolour,
              body: FutureBuilder<MyModel?>(
                  future: value.fetchweatherdata(town),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final weather = snapshot.data!;
                      // var weather23 = snapshot.data;
                      // var icons = WeatherStatus().getMessage(weather.main.temp.toInt());
                      return Container(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                (town),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 30),
                              ),
                              Text(
                                weather.timezone.toString(),
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 16),
                              ),
                              Text(
                                weather.weathers.toString(),
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 16),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Container(
                                  width: size.width,
                                  height: 200,
                                  decoration: BoxDecoration(
                                      color: myConstant.primarycolour,
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: [
                                        BoxShadow(
                                            color: myConstant.primarycolour
                                                .withOpacity(.5),
                                            offset: const Offset(0, 25),
                                            blurRadius: 10,
                                            spreadRadius: -12)
                                      ]),
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Positioned(
                                        child: SizedBox(
                                          child: Image.asset('assets/n1.webp',
                                              fit: BoxFit.cover),
                                          height: 120,
                                          width: 120,
                                        ),
                                        left: 30,
                                      ),
                                      Positioned(
                                        child: Text(weather.clouds.toString(),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold)),
                                        left: 35,
                                        bottom: 20,
                                      ),
                                      Positioned(
                                        child: Text(
                                          weather.main.temp.toString(),
                                          style: TextStyle(
                                              fontSize: 60,
                                              color: const Color.fromARGB(
                                                  26, 86, 76, 76)),
                                        ),
                                        right: 50,
                                        top: 10,
                                      )
                                    ],
                                  )),
                              SizedBox(
                                height: 40,
                                width: 600,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text("Wind Speed",
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 15)),
                                  Text("Humidity",
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 15)),
                                  Text("Max Temp",
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 15))
                                ],
                              ),
                              Row( 
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    child: Text("${weather.wind.speed} m/s"),
                                    padding: EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                        "${weather.main.humidity.toStringAsFixed(2)}"),
                                    padding: EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                        "${weather.main.tempMax.toStringAsFixed(2)}"),
                                    padding: EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  //                        Expanded(
                                  //   child: ListView.builder(
                                  //     itemCount: 24,
                                  //     itemBuilder: (context, index) {
                                  //       return ListTile(
                                  //         leading: Icon(Icons.sunny),
                                  //         title: Text('25°C'),
                                  //         subtitle: Text('10:00 AM'),
                                  //       );
                                  //     },
                                  //   ),
                                  // ),
                                ],
                              ),
                              SizedBox(
                                height: 40,
                                width: 600,
                              ),
                             
                            ],
                          ));
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    } else {
                      return CircularProgressIndicator();
                    }
                  }),
            ));
  }
}

// Future<MyModel> fetchweatherdata(String place) async {
//   var place2 = WelcomePage().place;

//   final Response = await http.get(Uri.parse(
//       'https://api.openweathermap.org/data/2.5/weather?q$place2=&appid=135da4f8722b429bbb31fe9c977c253a'));

//   if (Response.statusCode == 200) {
//     final jsonresponse = jsonDecode(Response.body);
//     final weather = MyModel.fromJson(jsonresponse);

//     return weather;
//   } else {
//     throw Exception('failed to fetch the weather');
//   }
// }
