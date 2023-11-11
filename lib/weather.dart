import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

class Weather {
  int temp ;
  int tempMax;
  int tempMin;
  String description;
  double lon;
  double lat;
  String icon;
  DateTime? time;
  int rainyPercent;

  Weather({
    this.temp = 0,this.tempMax = 0,this.tempMin = 0,this.description = 'none',
    this.lon = 0.0,this.lat = 0.0,this.icon = 'none',this.time ,this.rainyPercent = 0,
});

  static Future<Weather> getCurrentWeather(String zipCode) async{
    String _zipCode;
    if(zipCode.contains("-")){
      _zipCode  = zipCode;
    } else {
      _zipCode = zipCode.substring(0,3) + "-" + zipCode.substring(3);
    }
    String url = 'https://api.openweathermap.org/data/2.5/weather?zip=$_zipCode,JP&appid=7b44cd3d2ce28af8a110b484b9a80775&lang=ja&units=metric';
    try {
      var result = await get(Uri.parse(url));
      Map<String,dynamic> data = jsonDecode(result.body);
      Weather currentWeather = Weather(
        description: data['weather'][0]['description'] ,
        temp: data['main']['temp'].toInt(),
        tempMin: data['main']['temp_min'].toInt(),
        tempMax: data['main']['temp_max'].toInt(),
      );
      return currentWeather;
    } catch(e) {
      return Weather();
    }
  }
}