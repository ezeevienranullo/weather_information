import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:weather_info/services/weather_service.dart';
import 'package:weather_info/ui/common/def_response.dart';
import 'package:weather_info/ui/common/weather_key.dart';

import '../../../app/app.locator.dart';
import '../../../model/note_model.dart';
import '../../common/db_helper.dart';
import '../../common/helpers.dart';
import 'modal_input/note_view.dart';

class HomeViewModel extends BaseViewModel {
  final _weatherService = locator<WeatherService>();
  final DatabaseHelper dbHelper = DatabaseHelper.instance;

  BuildContext? context;
  HomeViewModel(this.context);

  CalendarFormat calendarFormat = CalendarFormat.month;
  DateTime selectedDay =  DateTime.now();
  Map<String, dynamic> weatherData = {};
  List<Note> notes = [];

  String _getLatitude = '8.465368';
  String get getLatitude => _getLatitude;
  String _getLongitude = '124.618452';
  String get getLongitude => _getLongitude;
  StreamSubscription<Position>? _positionStreamSubscription;

  init()async{
    await initLocation();
    await fetchWeatherData(selectedDay);
    await loadNotesForDate(selectedDay);
  }

  fetchWeatherData(DateTime date) async{
    String formattedDate = DateFormat('yyyy-MM-dd').format(date);

    String url = 'https://api.openweathermap.org/data/2.5/weather?lat=$getLatitude&lon=$getLongitude&date=$formattedDate&APPID=$WEATHER_APPID';
    print('url $url');

    setBusy(true);
    DefResponse response = await _weatherService.getWeather(url);
    setBusy(false);

    if(response.success){
      weatherData = response.data;
      notifyListeners();
    }else{
      print(response.message);
    }
  }

  setDay(selectedDay)async{
    initLocation();
    this.selectedDay = selectedDay;
    notifyListeners();
    await fetchWeatherData(selectedDay);
    await loadNotesForDate(selectedDay);
  }

  setCalendarFormat(calendarFormat){
    this.calendarFormat = calendarFormat;
    notifyListeners();
  }

  // Load notes from the database for a specific date
  Future<void> loadNotesForDate(DateTime date) async {
    String formattedDate = DateFormat('yyyy-MM-dd').format(date);
    final notes = await dbHelper.getNotesByDate(formattedDate);
    this.notes = notes;
    notifyListeners();
  }

  Future<void> showBottomSheet(date) async {
    final result = await showModalBottomSheet<bool>(context: context!,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (BuildContext context){
          return NoteView(selectedDate: date,);
        }
    );
    if(result != null){
      loadNotesForDate(selectedDay);
    }
  }

  initLocation()async{
    setBusy(true);
    await getCurrentPosition();
    if(await handleLocationPermission(context!)) {
      await locationListener();
    }
    setBusy(false);
  }

  Future<void> getCurrentPosition() async {
    final hasPermission = await handleLocationPermission(context!);

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {

      _getLatitude = position.latitude.toString();
      _getLongitude = position.longitude.toString();
      setBusy(false);
      notifyListeners();
    }).catchError((e) {
      debugPrint(e);
      print('_getCurrentPosition $e');
    });
  }

  locationListener() async {

    late LocationSettings locationSettings;
    TargetPlatform defaultTargetPlatform = TargetPlatform.android;

    if (defaultTargetPlatform == TargetPlatform.android) {
      locationSettings = AndroidSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
        forceLocationManager: true,
        intervalDuration: const Duration(seconds: 3),
      );
    } else if (defaultTargetPlatform == TargetPlatform.iOS || defaultTargetPlatform == TargetPlatform.macOS) {
      locationSettings = AppleSettings(
        accuracy: LocationAccuracy.high,
        activityType: ActivityType.fitness,
        distanceFilter: 10,
        pauseLocationUpdatesAutomatically: true,
        // Only set to true if our app will be started up in the background.
        showBackgroundLocationIndicator: false,
      );
    } else {
      locationSettings = const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      );
    }

    _positionStreamSubscription = Geolocator.getPositionStream(locationSettings: locationSettings).listen(
          (Position? position) {
        if(position != null) {
          _getLatitude = position.latitude.toString();
          _getLongitude = position.longitude.toString();
          setBusy(false);
          notifyListeners();
        }
      });
  }

}

