import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:intl/intl.dart';
import 'package:my_weather_app/controller/current_weather_controller.dart';
import 'package:my_weather_app/pages/search_page.dart';
import 'package:my_weather_app/utils/utils.dart';

import '../utils/const.dart';

class CurrentWeather extends StatelessWidget {
  const CurrentWeather({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<CurrentWeatherController>(builder: (controller) {
      var forecastList = controller.forecastWeatherResponse.value.list!;
      var currentData = controller.currentWeatherResponse.value;
      return GlowContainer(
        height: Get.height - 230,
        glowColor: const Color(0xff00A1FF).withOpacity(0.5),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(60),
          bottomRight: Radius.circular(60),
        ),
        spreadRadius: 5,
        child: Container(
          margin: const EdgeInsets.all(2),
          padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color(0xFF10BBF9),
              Color(0xFF0F6BF2),
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(60),
              bottomRight: Radius.circular(60),
            ),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(.3),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        controller.currentPosition();
                        controller.getData();
                      },
                      icon: const Icon(
                        Icons.my_location_rounded,
                        color: Colors.white,
                      ),
                    ),
                    Expanded(
                      child: TextButton.icon(
                        onPressed: null,
                        label: Text(
                          '${currentData.name}, ${currentData.sys!.country}',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        icon: const Icon(
                          Icons.location_on_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        showSearch(context: context, delegate: SearchClass())
                            .then((city) {
                          if (city != null && city.isNotEmpty) {
                            controller.convertAddressToLatLng(city);
                          }
                        });
                      },
                      icon: const Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 380,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      alignment: Alignment.topCenter,
                      child: Image(
                        image: AssetImage(
                          Util.findIcon(
                              '${currentData.weather![0].main}', true),
                        ),
                        height: 150,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Positioned(
                      bottom: 85,
                      right: 0,
                      left: 0,
                      child: Center(
                        child: Column(
                          children: [
                            GlowText(
                              '${currentData.main!.temp!.round()}$degree${controller.tempUnitSymbol}',
                              style: const TextStyle(
                                height: 0.1,
                                fontSize: 80,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              '${toBeginningOfSentenceCase(currentData.weather![0].main)}',
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white.withOpacity(.8)),
                            ),
                            Text(
                              Util.getFormattedDate(
                                  DateTime.fromMillisecondsSinceEpoch(
                                      currentData.dt!.toInt() * 1000)),
                              style: TextStyle(
                                  fontSize: 12, color: Colors.grey.shade300),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      child: Row(
                        children: [
                          GlowText(
                            "F°",
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: controller.isTempSwitch.value
                                    ? Colors.white
                                    : Colors.grey),
                          ),
                          CupertinoSwitch(
                            value: controller.isTempSwitch.value,
                            onChanged: (value) {
                              controller.isTempSwitch.value = value;
                              controller.changeThempUnite();
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: Get.width,
                    ),
                    Positioned(
                        bottom: 10,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.blueAccent,
                                      spreadRadius: 4,
                                      blurRadius: 10,
                                    )
                                  ],
                                  gradient: const LinearGradient(colors: [
                                    Color(0xFF10BBF9),
                                    Color(0xFF0F6BF2),
                                  ])),
                              child: Text(
                                'Sunrise ${getFormattedDate(currentData.sys!.sunrise!, pattern: 'hh:mm a')}  ',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12,
                                    color: Colors.white),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.blueAccent,
                                      spreadRadius: 4,
                                      blurRadius: 10,
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: const LinearGradient(colors: [
                                    Color(0xFF10BBF9),
                                    Color(0xFF0F6BF2),
                                  ])),
                              child: Text(
                                'Sunset ${getFormattedDate(currentData.sys!.sunset!, pattern: 'hh:mm a')}  ',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12,
                                    color: Colors.white),
                              ),
                            ),
                          ],
                        ))
                  ],
                ),
              ),
              const Divider(color: Colors.white),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      const Icon(CupertinoIcons.wind, color: Colors.white),
                      Text(
                        "${currentData.wind!.speed} Km/h",
                        style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                            color: Colors.white),
                      ),
                      const Text(
                        "Wind",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                            color: Colors.white),
                      )
                    ],
                  ),
                  Container(
                    color: Colors.white,
                    width: 1,
                    height: 20,
                  ),
                  Column(
                    children: [
                      const Icon(CupertinoIcons.drop, color: Colors.white),
                      const SizedBox(height: 10),
                      Text(
                        "${currentData.main!.humidity} %",
                        style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                            color: Colors.white),
                      ),
                      const Text(
                        "Humidity",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                            color: Colors.white),
                      )
                    ],
                  ),
                  Container(
                    color: Colors.white,
                    width: 1,
                    height: 20,
                  ),
                  Column(
                    children: [
                      const Icon(CupertinoIcons.cloud_rain,
                          color: Colors.white),
                      const SizedBox(height: 10),
                      Text(
                        "${currentData.clouds!.all} %",
                        style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                            color: Colors.white),
                      ),
                      const Text(
                        "Rain",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                            color: Colors.white),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}
