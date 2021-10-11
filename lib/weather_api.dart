import 'package:dio/dio.dart';

import 'dio_helper.dart';
import 'models/wether_m.dart';

class WeatherApi {
  Future<WetherM?> getCityWeather({String? appId, String? query}) async {
    Response response = await dioHelper.get("?q=$query&appid=$appId");
    if (response.statusCode == 200) {
      return WetherM.fromJson(response.data);
    } else {
      throw Exception("mama mia cant get the data");
    }
  }
}
