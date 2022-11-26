import 'dart:convert';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:http/http.dart' as Http;
import 'package:my_weather_app/models/current_weather_responce.dart';
import 'package:my_weather_app/models/forecast_weather_response.dart';

import '../utils/const.dart';

class CurrentWeatherController extends GetxController {
  var currentWeatherResponse = CurrentWeatherResponse().obs;
  var forecastWeatherResponse = ForecastWeatherResponse().obs;

  var latitude = 0.0.obs;
  var longitude = 0.0.obs;
  var tempUnit = metric.obs;
  var tempUnitSymbol = celsius.obs;
  var isTempSwitch = false.obs;

  @override
  void onInit() {
    currentPosition();
    getData();
  }

  changeThempUnite() {
    if (isTempSwitch.value) {
      tempUnit.value = imperial;
      tempUnitSymbol.value = fahrenheit;
    } else {
      tempUnit.value = metric;
      tempUnitSymbol.value = celsius;
    }
    getData();
    update();
  }

  currentPosition() {
    _determinePosition().then((position) {
      latitude.value = position.latitude;
      longitude.value = position.longitude;
      print("Lat :$latitude : lon :$longitude");
      getData();
      update();
    });
  }

  getData() {
    _getCurrentLocationResponse();
    _getForecastWeatherData();
  }

  Future<void> _getCurrentLocationResponse() async {
    EasyLoading.show(status: "Updating Weather..");
    final urlString =
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&units=$tempUnit&appid=$weatherApiKey';
    final response = await Http.get(Uri.parse(urlString));
    final map = json.decode(response.body);
    if (response.statusCode == 200) {
      currentWeatherResponse.value = CurrentWeatherResponse.fromJson(map);
      print(currentWeatherResponse);
      EasyLoading.dismiss();
      update();
    } else {
      print(map['message']);
    }
  }

  Future<void> _getForecastWeatherData() async {
    EasyLoading.show(status: "Updating Weather..");
    final urlString =
        'https://api.openweathermap.org/data/2.5/forecast?lat=$latitude&lon=$longitude&units=$tempUnit&appid=$weatherApiKey';
    final response = await Http.get(Uri.parse(urlString));
    final map = json.decode(response.body);
    if (response.statusCode == 200) {
      forecastWeatherResponse.value = ForecastWeatherResponse.fromJson(map);
      EasyLoading.dismiss();
      update();
    } else {
      print(map['message']);
    }
  }

  Future<void> convertAddressToLatLng(String city) async {
    print("value : $city");
    try {
      final locationList = await locationFromAddress(city);
      if (locationList.isNotEmpty) {
        final location = locationList.first;
        latitude.value = location.latitude;
        longitude.value = location.longitude;
        getData();
        update();
        print("lat $latitude log $longitude");
      } else {
        print('No location found from your provided address');
      }
    } catch (error) {
      print("Error is : $error");
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
}
