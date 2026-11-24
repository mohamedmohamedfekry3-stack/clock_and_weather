import 'package:dio/dio.dart';
import 'package:flutter_analog_clock/core/networking/get_weather.dart';

class AppStrings {
  AppStrings._();

  static Future<String> getTemprature() async {
    Response response = await GetWeather().getWeather();
    final Object? rawTemp = response.data['current']['temp_c'];
    if (rawTemp == null) {
      throw FormatException('Missing current.temp_c');
    }
    return rawTemp.toString();
  }

  static String formatWeatherValue(String tempCelsius) {
    return '$tempCelsius°C  •  Partly Cloudy';
  }

  static Future<String> getPreasureAndWind() async {
    Response response = await GetWeather().getWeather();
    final Object? rawTemp = response.data['current']['pressure_in'];
    final Object? rawTemp2 = response.data['current']['wind_kph'];
    if (rawTemp == null || rawTemp2 == null) {
      throw FormatException('Missing current.pressure_in or wind_kph');
    }
    return 'Preasure $rawTemp  |  Wind $rawTemp2 km/h';
  }

  static String formatWindAndPreasureValue(String wind, String preasure) {
    return 'Preasure $preasure  |  Wind $wind km/h';
  }

  static const String appTitle = 'TIMEORA';
  static const String quoteHeader = 'MAKE EVERY SECOND COUNT.';
  static const String quoteBody = 'Time is yours. Make it beautiful.';

  static const String weatherLabel = 'WEATHER & ATMOSPHERE';
  static const String weatherDetails = 'Humidity 45%  |  Wind 12 km/h';

  static const String nextAlarmLabel = 'NEXT ALARM';
  static const String nextAlarmTime = '06:30 AM';
  static const String nextAlarmSub = 'Tomorrow morning';

  static const String focusSessionLabel = 'FOCUS SESSION';
  static const String focusSessionTime = '25 MIN';
  static const String focusSessionSub = 'Stay productive';
}
