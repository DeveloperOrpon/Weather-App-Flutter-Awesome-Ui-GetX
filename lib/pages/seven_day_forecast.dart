import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:my_weather_app/models/forecast_weather_response.dart';

import '../utils/const.dart';
import '../utils/utils.dart';

class SevenDaysForecastPage extends StatelessWidget {
  final ForecastWeatherResponse forecast;

  const SevenDaysForecastPage({Key? key, required this.forecast})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.black,
            automaticallyImplyLeading: false,
            title: Row(
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        border: Border.all(
                          color: Colors.white,
                          width: 1,
                        )),
                    child: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  child: TextButton.icon(
                    icon: Icon(
                      Icons.calendar_today,
                      color: Colors.white,
                    ),
                    label: const Text(
                      "7 days",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    onPressed: null,
                  ),
                )
              ],
            ),
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                margin: EdgeInsets.only(bottom: 20),
                padding: EdgeInsets.only(top: 40),
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                  gradient: LinearGradient(colors: [
                    Color(0xFF10BBF9),
                    Color(0xFF52CCF8),
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image(
                      image: AssetImage(
                        Util.findIcon(
                            '${forecast.list![2].weather![0].main}', true),
                      ),
                      height: 150,
                      fit: BoxFit.fill,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          "Tommorow",
                          style: TextStyle(color: Colors.white, fontSize: 22),
                        ),
                        RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text:
                                    '${forecast.list![2].main!.tempMax!.round()}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 55,
                                    color: Colors.white),
                              ),
                              TextSpan(
                                text:
                                    '/${forecast.list![2].main!.tempMin!.round()}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                  color: Colors.white.withOpacity(.4),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "${forecast.list![2].weather![0].description}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white.withOpacity(.4),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: forecast.list!.length,
              (context, index) => Container(
                padding: const EdgeInsets.only(top: 15, bottom: 15),
                margin: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
                decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Color(0xFF10BBF9),
                      Color(0xFF52CCF8),
                    ]),
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey,
                      ),
                    )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      getFormattedDate(forecast.list![index].dt!,
                          pattern: 'EEE'),
                      style: TextStyle(
                          color: Colors.white.withOpacity(.5), fontSize: 18),
                    ),
                    Container(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image(
                            image: AssetImage(
                              Util.findIcon(
                                  '${forecast.list![index].weather![0].main}',
                                  true),
                            ),
                            height: 40,
                            fit: BoxFit.fill,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "${forecast.list![index].weather![0].main}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white.withOpacity(.4),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '+${forecast.list![2].main!.tempMax!.round()}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            ' +${forecast.list![2].main!.tempMin!.round()}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white.withOpacity(.4),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
