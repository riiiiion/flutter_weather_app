import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:untitled/weather.dart';
import 'package:untitled/zip_code.dart';

class TopPage extends StatefulWidget {
  const TopPage({super.key});

  @override
  State<TopPage> createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  Weather currentWeather =
      Weather(temp: 0, description: 'none', tempMax: 0, tempMin: 0);

  String address = 'ー';
  String? errorMessage ;
  List<Weather> hourlyWeather = [
    Weather(
        temp: 15,
        description: '晴れ',
        time: DateTime(2023, 11, 3, 10),
        rainyPercent: 0),
    Weather(
        temp: 16,
        description: '晴れ',
        time: DateTime(2023, 11, 3, 11),
        rainyPercent: 0),
    Weather(
        temp: 17,
        description: '晴れ',
        time: DateTime(2023, 11, 3, 12),
        rainyPercent: 90),
    Weather(
        temp: 18,
        description: '晴れ',
        time: DateTime(2023, 11, 3, 13),
        rainyPercent: 0),
    Weather(
        temp: 18,
        description: '晴れ',
        time: DateTime(2023, 11, 3, 13),
        rainyPercent: 0),
    Weather(
        temp: 18,
        description: '晴れ',
        time: DateTime(2023, 11, 3, 13),
        rainyPercent: 0),
    Weather(
        temp: 18,
        description: '晴れ',
        time: DateTime(2023, 11, 3, 13),
        rainyPercent: 0),
    Weather(
        temp: 18,
        description: '晴れ',
        time: DateTime(2023, 11, 3, 13),
        rainyPercent: 0),
    Weather(
        temp: 18,
        description: '晴れ',
        time: DateTime(2023, 11, 3, 13),
        rainyPercent: 0),
  ];

  List<Weather> dailyWeather = [
    Weather(
        tempMax: 20, tempMin: 26, rainyPercent: 0, time: DateTime(2021, 10, 1)),
    Weather(
        tempMax: 20,
        tempMin: 26,
        rainyPercent: 10,
        time: DateTime(2021, 10, 2)),
    Weather(
        tempMax: 20,
        tempMin: 26,
        rainyPercent: 20,
        time: DateTime(2021, 10, 3)),
    Weather(
        tempMax: 20, tempMin: 26, rainyPercent: 0, time: DateTime(2021, 10, 1)),
    Weather(
        tempMax: 20,
        tempMin: 26,
        rainyPercent: 10,
        time: DateTime(2021, 10, 2)),
    Weather(
        tempMax: 20,
        tempMin: 26,
        rainyPercent: 20,
        time: DateTime(2021, 10, 3)),
    Weather(
        tempMax: 20, tempMin: 26, rainyPercent: 0, time: DateTime(2021, 10, 1)),
    Weather(
        tempMax: 20,
        tempMin: 26,
        rainyPercent: 10,
        time: DateTime(2021, 10, 2)),
    Weather(
        tempMax: 20,
        tempMin: 26,
        rainyPercent: 20,
        time: DateTime(2021, 10, 3)),
  ];
  List<String> weekDay = [
    '月',
    '火',
    '水',
    '木',
    '金',
    '土',
    '日',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
                width: 200,
                child: TextField(
                  onSubmitted: (value) async {
                    Map<String,String> response = {};
                    response = await ZipCode.searchAddressFromZipCode(value);
                    await Weather.getCurrentWeather(value);
                    errorMessage = response['message'];
                    if(response.containsKey('address')) {
                      address = response['address'] ?? '該当なし';

                      currentWeather = await Weather.getCurrentWeather(value);
                      print(currentWeather);
                    }
                    setState(() {});
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(hintText: '郵便番号を入力'),
                )),
            Text(errorMessage ?? '' ,style: TextStyle(color: Colors.red), ),
            SizedBox(
              height: 50,
            ),
            Text(
              address,
              style: TextStyle(fontSize: 25),
            ),
            Text(currentWeather.description == 'none' ? 'ー' : currentWeather.description),
            Text(currentWeather.description == 'none' ? 'ー' :
              '${currentWeather.temp}°',
              style: TextStyle(fontSize: 80),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(currentWeather.description == 'none' ? '最高:ー' :'最高:${currentWeather.tempMax}'),
                ),
                Text(currentWeather.description == 'none' ? '最高:ー' :'最低:${currentWeather.tempMin}')
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Divider(
              height: 0,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: hourlyWeather.map((weather) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 8.0),
                    child: Column(
                      children: [
                        Text(
                            '${DateFormat('H').format(weather.time ?? DateTime(2000, 1, 1, 0))}時'),
                        Text('${weather.rainyPercent}%',
                            style: TextStyle(color: Colors.lightBlueAccent)),
                        const Icon(Icons.wb_sunny_sharp),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            '${weather.temp}°',
                            style: TextStyle(fontSize: 18),
                          ),
                        )
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            Divider(
              height: 0,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    children: dailyWeather.map((weather) {
                      return Container(
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 50,
                              child: Text(
                                  '${weekDay[(weather.time ?? DateTime(2000, 1, 1, 0)).weekday - 1]}曜日'),
                            ),
                            Row(
                              children: [
                                Icon(Icons.wb_sunny_sharp),
                                Text(
                                  '${weather.rainyPercent}%',
                                  style:
                                      TextStyle(color: Colors.lightBlueAccent),
                                ),
                              ],
                            ),
                            Container(
                              width: 50,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${weather.tempMax}',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    '${weather.tempMin}',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black.withOpacity(0.4)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
