import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:weatherapplite/function/homefun.dart';
import 'package:weatherapplite/models/constanst_colors.dart';

import 'package:weatherapplite/ui/welcome_page.dart';

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    constaant myconstant = constaant();
    // var brightness = MediaQuery.of(context).platformBrightness;
    // bool isDarkMode = Brightness == Brightness.dark;

    return Consumer<weatherdata>(builder: (context, value, child) => 
    Scaffold(
      appBar: AppBar(
        title: Text("eweather APP "),
      ),
      body: Container(
        width: size.width,
        height: size.height,
        // color: myconstant.primarycolour.withOpacity(.5),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('assets/n1.webp'),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WelcomePage()
                      ));
                },
                child: Container(
                  height: 50,
                  width: size.width * 0.7,
                  decoration: BoxDecoration(
                      color: myconstant.primarycolour,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: const Center(
                    child: Text('lets get start',
                        style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0), fontSize: 18)),
                  ),
                ), 
              ),
           
            ],
          ),
           
        ),

      ),
      
   ) );
  }
}
