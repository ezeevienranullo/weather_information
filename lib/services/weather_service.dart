import 'dart:convert';

import 'package:stacked/stacked.dart';

import '../ui/common/app_strings.dart';
import '../ui/common/def_response.dart';
import 'package:http/http.dart' as http;

class WeatherService with ListenableServiceMixin{

  WeatherService(){
    listenToReactiveValues([]);
  }

  Future? getWeather(String url) async {
    try {
      final response = await http.get(
          Uri.parse(url),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return DefResponse(success: true, data: data);
      } else {
        return DefResponse(success: false, message: str_something_went_wrong);
      }
    } catch (e) {
      return DefResponse(success: false, message: e.toString());
    }
  }
}