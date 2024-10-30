import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_info/ui/common/app_strings.dart';
import 'package:weather_info/ui/common/opensans_text.dart';

Future? handleLocationPermission(BuildContext context) async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    promptDialog(context);
    return false;
  }
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location permissions are denied')));
      return false;
    }
  }
  if (permission == LocationPermission.deniedForever) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
            'Location permissions are permanently denied, we cannot request permissions.')));
    return false;
  }
  return true;
}

void promptDialog(context){

  CommonDialog().alert(context!,
    child: Container(
      height: 190, padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.warning_rounded, color: Colors.orange, size: 25,),
              const SizedBox(width: 5,),
              OpenSansText.semiBold(str_warning, Colors.orange, 16),
            ],
          ),
          const SizedBox(height: 10,),
          Expanded(child: Text(location_permission, style: mediumOpenSansStyle(Colors.black,14.0, FontWeight.bold), overflow: TextOverflow.ellipsis, maxLines: 5,)),
          Spacer(),
          Row(
            children: [
              ElevatedButton(
                child: OpenSansText.regular(str_later, Colors.white, 13),
               onPressed: () {  Navigator.of(context, rootNavigator: true).pop(); },),
              Spacer(),
              ElevatedButton(
                child: OpenSansText.regular(str_settings, Colors.white, 13),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                  if(Platform.isAndroid) {
                    _openLocationSettings();
                  }else{
                    _openAppSettings();
                  }
                },
              ),
            ],
          )
        ],
      ),
    ),
  );
}

void _openAppSettings() async {
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;

  final opened = await _geolocatorPlatform.openAppSettings();
  String displayValue;
  if (opened) {
    displayValue = 'Opened Application Settings.';
  } else {
    displayValue = 'Error opening Application Settings.';
  }
  print(displayValue);
}

void _openLocationSettings() async {
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;

  final opened = await _geolocatorPlatform.openLocationSettings();
  String displayValue;
  if (opened) {
    displayValue = 'Opened Location Settings';
  } else {
    displayValue = 'Error opening Location Settings';
  }
  print(displayValue);
}

class CommonDialog {
  void alert(
      BuildContext context, {
        Function? onButtonPressed,
        required Widget child,
      }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: child,
        );
      },
    );
  }
}