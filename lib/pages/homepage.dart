import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:my_weather_app/models/forecast_weather_response.dart';
import 'package:my_weather_app/pages/current_weather.dart';
import 'package:my_weather_app/pages/seven_day_forecast.dart';

import '../controller/current_weather_controller.dart';
import '../utils/const.dart';
import '../utils/utils.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(CurrentWeatherController());
    return Scaffold(
      backgroundColor: Colors.black,
      body: GetX<CurrentWeatherController>(builder: (controller) {
        if (controller.currentWeatherResponse.value.main == null ||
            controller.forecastWeatherResponse.value.list == null) {
          return const SpinKitSpinningLines(
            color: Colors.blue,
            size: 60.0,
          );
        }
        return Column(
          children: [
            const CurrentWeather(),
            Container(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Today",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Get.to(() => SevenDaysForecastPage(
                            forecast:
                                controller.forecastWeatherResponse.value));
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text(
                            "7 days",
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.grey,
                            size: 18,
                          ),
                        ],
                      ))
                ],
              ),
            ),
            Expanded(
              child: _forecastWeatherSection(
                controller.forecastWeatherResponse.value,
                controller,
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _forecastWeatherSection(
      ForecastWeatherResponse forecastWeatherResponse,
      CurrentWeatherController controller) {
    final forecastList = forecastWeatherResponse.list!;
    return SizedBox(
      height: 170,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: forecastList.length,
        itemBuilder: (context, index) {
          final item = forecastList[index];
          return Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(8),
            width: 120,
            height: 170,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: const LinearGradient(colors: [
                Color(0xFF10BBF9),
                Color(0xFF0F6BF2),
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Text(
                      getFormattedDate(item.dt!, pattern: 'EEE hh:mm a'),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Image(
                      image: AssetImage(
                        Util.findIcon('${item.weather![0].main}', false),
                      ),
                      width: 40,
                      height: 40,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '${item.main!.tempMax!.round()}/${item.main!.tempMin!.round()}$degree ${controller.tempUnitSymbol}',
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      item.weather![0].description!,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
