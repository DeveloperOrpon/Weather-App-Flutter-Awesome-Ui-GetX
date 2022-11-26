import 'package:intl/intl.dart';

class Util {
  static String getFormattedDate(DateTime dateTime) {
    return DateFormat('EEE, d, MMM,yyyy hh:mm')
        .format(dateTime); //Tue, May 5, 2022
  }

  static String findIcon(String name, bool type) {
    if (type) {
      switch (name) {
        case "Clouds":
          return "assets/clouds.png";
        case "Rain":
          return "assets/rainy.png";
        case "Drizzle":
          return "assets/rainy.png";
        case "Thunderstorm":
          return "assets/thunder.png";
        case "Snow":
          return "assets/snow.png";
        case "Wind":
          return "assets/wind.png";
        case "Haze":
          return "assets/haze.png";
        case "Mist":
          return "assets/mist.png";
        default:
          return "assets/sunny.png";
      }
    } else {
      switch (name) {
        case "Clouds":
          return "assets/clouds.png";
        case "Rain":
          return "assets/rainy.png";
        case "Drizzle":
          return "assets/rainy.png";
        case "Thunderstorm":
          return "assets/thunder.png";
        case "Snow":
          return "assets/snow.png";
        case "Wind":
          return "assets/wind.png";
        case "Haze":
          return "assets/haze.png";
        case "Mist":
          return "assets/mist.png";
        default:
          return "assets/sunny.png";
      }
    }
  }
}
